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

    public func assemble(navigationController: NavigationController, flowFinishHandler: (() -> Void)?) -> ProfileEditorCoordinatorProtocol {
        let content: ProfileEditorCoordinator.Content = { middlewareDelegate in
            let screen = makeScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        return ProfileEditorCoordinator(
            content: content,
            flowFinishHandler: flowFinishHandler,
            navigationController: navigationController
        )
    }

    private func makeScreen(middlewareDelegate: ProfileEditorMiddlewareDelegate) -> ProfileEditorScreen {
        let initialState = ProfileEditorState()
        let reducer = ProfileEditorReducer()
        let middleware = ProfileEditorMiddleware(
            getTopicListUseCase: .init(topicRepository: dependencies.topicRepository),
            updateUserAvatarUseCase: UpdateUserAvatarUseCase(profileRepository: dependencies.profileRepository),
            updateUserProfileUseCase: UpdateUserProfileUseCase(profileRepository: dependencies.profileRepository),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: initialState, reducer: reducer, middleware: middleware)

        return ProfileEditorScreen(store: store)
    }
}
