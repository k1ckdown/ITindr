//
//  ProfileMiddleware.swift
//  UserList
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UDFKit
import Navigation
import ProfileDomain

@MainActor
protocol ProfileMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToBack()
    func showUserMatch(userId: String)
}

final class ProfileMiddleware: Middleware {

    private let profile: UserProfile
    private let likeUserUseCase: LikeUserUseCase
    private let dislikeUserUseCase: DislikeUserUseCase
    private weak var delegate: ProfileMiddlewareDelegate?

    init(
        profile: UserProfile,
        likeUserUseCase: LikeUserUseCase,
        dislikeUserUseCase: DislikeUserUseCase,
        delegate: ProfileMiddlewareDelegate?
    ) {
        self.profile = profile
        self.likeUserUseCase = likeUserUseCase
        self.dislikeUserUseCase = dislikeUserUseCase
        self.delegate = delegate
    }

    func handle(state: ProfileState, intent: ProfileIntent) async -> ProfileIntent? {
        switch intent {
        case .dataLoaded: break
        case .onAppear:
            return .dataLoaded(profile)
        case .likeTapped:
            await likeUser()
        case .rejectTapped:
            await dislikeUser()
        }

        return nil
    }
}

// MARK: - Private methods

private extension ProfileMiddleware {

    func likeUser() async {
        do {
            let isMutual = try await likeUserUseCase.execute(userId: profile.id)
            if isMutual { await delegate?.showUserMatch(userId: profile.id) }
        } catch {
            await delegate?.showError(error.localizedDescription)
        }
    }

    func dislikeUser() async {
        do {
            try await dislikeUserUseCase.execute(userId: profile.id)
            await delegate?.goToBack()
        } catch {
            await delegate?.showError(error.localizedDescription)
        }
    }
}
