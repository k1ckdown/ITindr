//
//  UserMatchCoordinatorAssembly.swift
//  UserMatch
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UDFKit
import SwiftUI
import Navigation
import UserMatchInterface

public struct UserMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(
        userId: String,
        cancelHandler: (() -> Void)?,
        navigationController: NavigationController
    ) -> UserMatchCoordinatorProtocol {
        let content: UserMatchCoordinator.Content = { middlewareDelegate in
            let reducer = UserMatchReducer()
            let middleware = UserMatchMiddleware(
                userId: userId,
                createChatUseCase: .init(chatRepository: dependencies.chatRepository),
                delegate: middlewareDelegate
            )

            let store = Store(initialState: .init(), reducer: reducer, middleware: middleware)
            let screen = UserMatchScreen(store: store)
            let hostingController = UIHostingController(rootView: screen)

            hostingController.rootView = UserMatchScreen(store: store, cancelHandler: { [weak hostingController] in
                hostingController?.dismiss(animated: true)
                cancelHandler?()
            })

            return hostingController
        }

        return UserMatchCoordinator(
            content: content,
            chatCoordinatorAssembly: dependencies.chatCoordinatorAssembly,
            navigationController: navigationController
        )
    }
}
