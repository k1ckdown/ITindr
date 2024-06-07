//
//  ChatCoordinatorAssembly.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import Navigation
import ChatInterface

public typealias Chat = ChatInterface.Chat

public struct ChatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(chat: Chat, navigationController: NavigationController) -> ChatCoordinatorProtocol {
        let content: ChatCoordinator.Content = { middlewareDelegate in
            let reducer = ChatReducer()
            let middleware = ChatMiddleware(
                chat: chat,
                sendMessageUseCase: .init(chatRepository: dependencies.chatRepository),
                getMessageListUseCase: .init(chatRepository: dependencies.chatRepository),
                delegate: middlewareDelegate
            )

            let store = Store(initialState: .idle, reducer: reducer, middleware: middleware)
            return ChatViewController(store: store)
        }

        return ChatCoordinator(content: content, navigationController: navigationController)
    }
}
