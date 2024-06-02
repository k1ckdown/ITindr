//
//  ChatListCoordinatorAssembly.swift
//  ChatList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import Navigation
import ChatListInterface

public struct ChatListCoordinatorAssembly: ChatListCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> ChatListCoordinatorProtocol {
        let content: ChatListCoordinator.Content = { middlewareDelegate in
            let reducer = ChatListReducer()
            let middleware = ChatListMiddleware(
                getChatListUseCase: .init(chatRepository: dependencies.chatRepository),
                delegate: middlewareDelegate
            )

            let store = Store(initialState: ChatListState.idle, reducer: reducer, middleware: middleware)
            return ChatListViewController(store: store)
        }

        return ChatListCoordinator(content: content, navigationController: navigationController)
    }
}
