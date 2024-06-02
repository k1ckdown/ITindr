//
//  ChatListCoordinator.swift
//  ChatList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import CommonUI
import Navigation
import ChatListInterface

final class ChatListCoordinator: BaseCoordinator, ChatListCoordinatorProtocol {
    typealias Content = (ChatListMiddlewareDelegate) -> UIViewController

    private let content: Content

    init(content: @escaping Content, navigationController: NavigationController) {
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        content.navigationItem.title = ChatListStrings.chats
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: Colors.accentColor.color]

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }
}

extension ChatListCoordinator: ChatListMiddlewareDelegate {

}
