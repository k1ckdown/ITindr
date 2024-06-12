//
//  ProfileEditorCoordinatorAssembly.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit
import SwiftUI
import Navigation
import ProfileEditorInterface

public struct ProfileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(config: ProfileEditorConfig) -> ProfileEditorCoordinatorProtocol {
        let content: ProfileEditorCoordinator.Content = { middlewareDelegate in
            let screen = makeScreen(config: config, middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        return ProfileEditorCoordinator(
            content: content,
            navigationTitle: config.navigationTitle,
            flowFinishHandler: config.flowFinishHandler,
            navigationController: config.navigationController
        )
    }
}

// MARK: - Private methods

private extension ProfileEditorCoordinatorAssembly {

    func getInitialState(from profile: Profile) -> ProfileEditorState {
        ProfileEditorState(
            name: .init(content: profile.name),
            aboutMyself: profile.aboutMyself,
            avatarUrl: profile.avatarUrl,
            avatarData: profile.avatarData,
            selectedTopicIds: profile.topics.map(\.id)
        )
    }

    func makeScreen(config: ProfileEditorConfig, middlewareDelegate: ProfileEditorMiddlewareDelegate) -> ProfileEditorScreen {
        let reducer = ProfileEditorReducer()
        let middleware = ProfileEditorMiddleware(
            getTopicListUseCase: GetTopicListUseCase(topicRepository: dependencies.topicRepository),
            updateUserAvatarUseCase: UpdateUserAvatarUseCase(profileRepository: dependencies.profileRepository),
            deleteUserAvatarUseCase: DeleteUserAvatarUseCase(profileRepository: dependencies.profileRepository),
            updateUserProfileUseCase: UpdateUserProfileUseCase(profileRepository: dependencies.profileRepository),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: getInitialState(from: config.profile), reducer: reducer, middleware: middleware)
        return ProfileEditorScreen(isNavBarHidden: config.isNavigationBarHidden, screenTitle: config.screenTitle, interestsHeader: config.interestsHeader, store: store)
    }
}
