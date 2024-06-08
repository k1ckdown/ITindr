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

    private var selectedTopicIds = [String]()
    private let getTopicListUseCase: GetTopicListUseCase
    private let updateUserAvatarUseCase: UpdateUserAvatarUseCase
    private let updateUserProfileUseCase: UpdateUserProfileUseCase
    private weak var delegate: ProfileEditorMiddlewareDelegate?

    init(
        getTopicListUseCase: GetTopicListUseCase,
        updateUserAvatarUseCase: UpdateUserAvatarUseCase,
        updateUserProfileUseCase: UpdateUserProfileUseCase,
        delegate: ProfileEditorMiddlewareDelegate?
    ) {
        self.getTopicListUseCase = getTopicListUseCase
        self.updateUserAvatarUseCase = updateUserAvatarUseCase
        self.updateUserProfileUseCase = updateUserProfileUseCase
        self.delegate = delegate
    }

    func handle(state: ProfileEditorState, intent: ProfileEditorIntent) async -> ProfileEditorIntent? {
        switch intent {
        case .onAppear:
            return await getTopics()
        case .topicTapped(let id):
            handleTopicTap(id: id)
        case .saveTapped:
            await handleSaveTap(state: state)
        default: break
        }

        return nil
    }
}

// MARK: - Public methods

private extension ProfileEditorMiddleware {

    func handleTopicTap(id: String) {
        if let index = selectedTopicIds.firstIndex(of: id) {
            selectedTopicIds.remove(at: index)
        } else {
            selectedTopicIds.append(id)
        }
    }

    func getTopics() async -> ProfileEditorIntent {
        do {
            let topics = try await getTopicListUseCase.execute()
            return .topicsLoaded(topics)
        } catch {
            return .topicsLoadFailed(error.localizedDescription)
        }
    }

    func handleSaveTap(state: ProfileEditorState) async {
        // TODO: Show error that field is required
        guard state.name.isValid else { return }

        let profile = UserProfileEdit(name: state.name.content, aboutMyself: state.aboutMyself, topics: selectedTopicIds)
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
