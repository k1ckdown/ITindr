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
    func goToProfile(_ user: UserProfile)
    func showUserMatch(userId: String, cancelHandler: (() -> Void)?)
}

final class FeedMiddleware: Middleware {

    var cancelMatchHandler: ((UserProfile?) -> Void)?
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
            guard case .loading = state else { break }
            return await getUsers()
        case .likeTapped:
            return await likeUser()
        case .rejectTapped:
            await dislikeUser()
            return .userSelected(getNextUser())
        case .avatarTapped:
            guard let currentUser else { break }
            await delegate?.goToProfile(currentUser)
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

    func showUserMatch(userId: String) async {
        let cancelHandler: () -> Void = { [weak self] in
            self?.cancelMatchHandler?(self?.getNextUser())
        }

        await delegate?.showUserMatch(userId: userId, cancelHandler: cancelHandler)
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

            await showUserMatch(userId: currentUser.id)
            return .usersMatched
        } catch {
            await delegate?.showError(error.localizedDescription)
            return nil
        }
    }
}
