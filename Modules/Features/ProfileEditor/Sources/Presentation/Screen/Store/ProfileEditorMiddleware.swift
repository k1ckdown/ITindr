//
//  ProfileEditorMiddleware.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit
import Navigation
import TopicDomain
import ProfileDomain

@MainActor
protocol ProfileEditorMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToNext()
}

final class ProfileEditorMiddleware: Middleware {

    private var topics = [Topic]()
    private let getTopicListUseCase: GetTopicListUseCase
    private let updateUserAvatarUseCase: UpdateUserAvatarUseCase
    private let deleteUserAvatarUseCase: DeleteUserAvatarUseCase
    private let updateUserProfileUseCase: UpdateUserProfileUseCase
    private weak var delegate: ProfileEditorMiddlewareDelegate?

    init(
        getTopicListUseCase: GetTopicListUseCase,
        updateUserAvatarUseCase: UpdateUserAvatarUseCase,
        deleteUserAvatarUseCase: DeleteUserAvatarUseCase,
        updateUserProfileUseCase: UpdateUserProfileUseCase,
        delegate: ProfileEditorMiddlewareDelegate?
    ) {
        self.getTopicListUseCase = getTopicListUseCase
        self.updateUserAvatarUseCase = updateUserAvatarUseCase
        self.deleteUserAvatarUseCase = deleteUserAvatarUseCase
        self.updateUserProfileUseCase = updateUserProfileUseCase
        self.delegate = delegate
    }

    func handle(state: ProfileEditorState, intent: ProfileEditorIntent) async -> ProfileEditorIntent? {
        switch intent {
        case .onAppear:
            return await getTopics()
        case .saveTapped:
            await handleSaveTap(state: state)
        default: break
        }

        return nil
    }
}

// MARK: - Public methods

private extension ProfileEditorMiddleware {

    func getTopics() async -> ProfileEditorIntent {
        do {
            topics = try await getTopicListUseCase.execute()
            return .topicsLoaded(topics)
        } catch {
            return .topicsLoadFailed(error.localizedDescription)
        }
    }

    func handleSaveTap(state: ProfileEditorState) async {
        // TODO: Show error that field is required
        guard state.name.isValid else { return }

        let selectedTopics = topics.filter { state.selectedTopicIds.contains($0.id) }
        let profile = UserProfileEdit(name: state.name.content, aboutMyself: state.aboutMyself, topics: selectedTopics)
        do {
            try await updateUserProfileUseCase.execute(profile)
            if let avatar = state.chosenAvatar {
                try await updateUserAvatarUseCase.execute(avatar)
            } else if state.avatarData == nil, state.avatarUrl == nil {
                try await deleteUserAvatarUseCase.execute()
            }

            await delegate?.goToNext()
        } catch {
            await delegate?.showError(error.localizedDescription)
        }
    }
}
