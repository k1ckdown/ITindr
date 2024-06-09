//
//  ProfileEditorCoordinatorAssembly.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit
import SwiftUI
import Navigation
import ProfileDomain
import ProfileEditorInterface

public struct ProfileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(
        profile: Profile,
        isNavigationBarHidden: Bool,
        navigationController: NavigationController,
        flowFinishHandler: (() -> Void)?
    ) -> ProfileEditorCoordinatorProtocol {
        let content: ProfileEditorCoordinator.Content = { middlewareDelegate in
            let screen = makeScreen(profile: profile, isNavigationBarHidden: isNavigationBarHidden, middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        return ProfileEditorCoordinator(
            content: content,
            flowFinishHandler: flowFinishHandler,
            navigationController: navigationController
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
            selectedTopicIds: profile.topics.map(\.id)
        )
    }

    func makeScreen(profile: Profile, isNavigationBarHidden: Bool, middlewareDelegate: ProfileEditorMiddlewareDelegate) -> ProfileEditorScreen {
        let reducer = ProfileEditorReducer()
        let middleware = ProfileEditorMiddleware(
            getTopicListUseCase: GetTopicListUseCase(topicRepository: dependencies.topicRepository),
            updateUserAvatarUseCase: UpdateUserAvatarUseCase(profileRepository: dependencies.profileRepository),
            deleteUserAvatarUseCase: DeleteUserAvatarUseCase(profileRepository: dependencies.profileRepository),
            updateUserProfileUseCase: UpdateUserProfileUseCase(profileRepository: dependencies.profileRepository),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: getInitialState(from: profile), reducer: reducer, middleware: middleware)

        return ProfileEditorScreen(isNavBarHidden: isNavigationBarHidden, store: store)
    }
}
