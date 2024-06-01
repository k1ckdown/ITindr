//
//  ProfileEditorMiddleware.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit
import Navigation
import ProfileDomain

@MainActor
protocol ProfileEditorMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToNext()
}

final class ProfileEditorMiddleware: Middleware {

    private let updateUserAvatarUseCase: UpdateUserAvatarUseCase
    private let updateUserProfileUseCase: UpdateUserProfileUseCase
    private weak var delegate: ProfileEditorMiddlewareDelegate?

    init(
        updateUserAvatarUseCase: UpdateUserAvatarUseCase,
        updateUserProfileUseCase: UpdateUserProfileUseCase,
        delegate: ProfileEditorMiddlewareDelegate?
    ) {
        self.updateUserAvatarUseCase = updateUserAvatarUseCase
        self.updateUserProfileUseCase = updateUserProfileUseCase
        self.delegate = delegate
    }

    func handle(state: ProfileEditorState, intent: ProfileEditorIntent) async -> ProfileEditorIntent? {
        switch intent {
        case .saveTapped: await handleSaveTap(state: state)
        default: break
        }

        return nil
    }
}

// MARK: - Public methods

private extension ProfileEditorMiddleware {

    func handleSaveTap(state: ProfileEditorState) async {
        // TODO: Show error that field is required
        guard state.name.isValid else { return }

        let profile = UserProfileEdit(name: state.name.content, aboutMyself: state.aboutMyself, topics: [])
        do {
            try await updateUserProfileUseCase.execute(profile)
            if let avatar = state.chosenAvatar {
                try await updateUserAvatarUseCase.execute(avatar)
            }
            await delegate?.goToNext()
        } catch {
            await delegate?.showError(error.localizedDescription)
        }
    }
}
