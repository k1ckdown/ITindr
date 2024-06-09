//
//  ProfileMiddleware.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UDFKit
import Navigation
import ProfileDomain

@MainActor
protocol ProfileMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToEditor(_ profile: UserProfile)
}

final class ProfileMiddleware: Middleware {

    private var profile: UserProfile?
    private let getUserProfileUseCase: GetUserProfileUseCase
    private weak var delegate: ProfileMiddlewareDelegate?

    init(getUserProfileUseCase: GetUserProfileUseCase, delegate: ProfileMiddlewareDelegate?) {
        self.getUserProfileUseCase = getUserProfileUseCase
        self.delegate = delegate
    }

    func handle(state: ProfileState, intent: ProfileIntent) async -> ProfileIntent? {
        switch intent {
        case .dataLoaded, .dataLoadFailed: break
        case .onAppear:
            return await getProfile()
        case .editTapped:
            guard let profile else { return nil }
            await delegate?.goToEditor(profile)
        }

        return nil
    }
}

// MARK: - Private methods

private extension ProfileMiddleware {

    func getProfile() async -> ProfileIntent {
        do {
            let profile = try await getUserProfileUseCase.execute()
            self.profile = profile
            return .dataLoaded(profile)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .dataLoadFailed(error.localizedDescription)
        }
    }
}
