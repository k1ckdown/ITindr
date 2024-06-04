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

    override func start() {
        let viewController = ChatViewController(with: .init(chatId: ""))

        addPopHandler(for: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
