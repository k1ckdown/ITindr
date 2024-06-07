//
//  FeedMiddlewareDelegate.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import Navigation
import ProfileDomain

@MainActor
protocol FeedMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func showUserMatch()
}

final class FeedMiddleware: Middleware {

    private var currentUser: UserProfile?
    private var users: [UserProfile] = []
    private let likeUserUseCase: LikeUserUseCase
    private let dislikeUserUseCase: DislikeUserUseCase
    private let getUsersFeedUseCase: GetUsersFeedUseCase
    private weak var delegate: FeedMiddlewareDelegate?

    init(
        likeUserUseCase: LikeUserUseCase,
        dislikeUserUseCase: DislikeUserUseCase,
        getUsersFeedUseCase: GetUsersFeedUseCase,
        delegate: FeedMiddlewareDelegate?
    ) {
        self.likeUserUseCase = likeUserUseCase
        self.dislikeUserUseCase = dislikeUserUseCase
        self.getUsersFeedUseCase = getUsersFeedUseCase
        self.delegate = delegate
    }

    func handle(state: FeedState, intent: FeedIntent) async -> FeedIntent? {
        switch intent {
        case .userSelected, .loadFailed, .usersMatched: break
        case .onAppear:
            return await getUsers()
        case .likeTapped:
            return await likeUser()
        case .rejectTapped:
            await dislikeUser()
            return .userSelected(getNextUser())
        case .usersMatchDisappear:
            return .userSelected(getNextUser())
        case .avatarTapped: break
        case .writeMessageTapped: break
        }

        return nil
    }
}

// MARK: - Private methods

private extension FeedMiddleware {

    func getNextUser() -> UserProfile? {
        currentUser = users.isEmpty ? nil : users.removeFirst()
        return currentUser
    }

    func dislikeUser() async {
        guard let currentUser else { return }

        do {
            try await dislikeUserUseCase.execute(userId: currentUser.id)
        } catch {
            await delegate?.showError(error.localizedDescription)
        }
    }

    func likeUser() async -> FeedIntent? {
        guard let currentUser else { return nil }
        
        do {
            let isMutual = try await likeUserUseCase.execute(userId: currentUser.id)
            guard isMutual else { return .userSelected(getNextUser())}

            await delegate?.showUserMatch()
            return .usersMatched
        } catch {
            await delegate?.showError(error.localizedDescription)
            return nil
        }
    }

    func getUsers() async -> FeedIntent {
        do {
            users = try await getUsersFeedUseCase.execute()
            return .userSelected(getNextUser())
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loadFailed(error.localizedDescription)
        }
    }
}
