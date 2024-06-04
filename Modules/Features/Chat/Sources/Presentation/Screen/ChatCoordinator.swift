//
//  ChatCoordinator.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit
import Navigation
import ChatInterface

final class ChatCoordinator: BaseCoordinator, ChatCoordinatorProtocol {
    typealias Content = (ChatMiddlewareDelegate) -> UIViewController

    private let content: Content

    init(content: @escaping Content, navigationController: NavigationController) {
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - ChatMiddlewareDelegate

extension ChatCoordinator: ChatMiddlewareDelegate {}
