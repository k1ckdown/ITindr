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
        case .likeTapped: break

        case .rejectTapped:
            await delegate?.goToBack()
        }

        return nil
    }
}

// MARK: - Private methods

private extension ProfileMiddleware {

    func likeUser() async {
        
    }
}
