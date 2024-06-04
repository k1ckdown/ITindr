//
//  ChatListCoordinator.swift
//  ChatList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import CommonUI
import Navigation
import ChatInterface
import ChatListInterface

final class ChatListCoordinator: BaseCoordinator, ChatListCoordinatorProtocol {
    typealias Content = (ChatListMiddlewareDelegate) -> UIViewController

    private let content: Content
    private let chatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol

    init(
        content: @escaping Content,
        navigationController: NavigationController,
        chatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol
    ) {
        self.content = content
        self.chatCoordinatorAssembly = chatCoordinatorAssembly
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        content.navigationItem.title = ChatListStrings.chats
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - ChatListMiddlewareDelegate

extension ChatListCoordinator: ChatListMiddlewareDelegate {

    func goToChat(with id: String) {
        let chatCoordinator = chatCoordinatorAssembly.assemble(chatId: id, navigationController: navigationController)
        coordinate(to: chatCoordinator)
    }
}
