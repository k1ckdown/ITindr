//
//  ChatListCoordinator.swift
//  ChatList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import ChatListInterface

final class ChatListCoordinator: BaseCoordinator, ChatListCoordinatorProtocol {
    
    override func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemIndigo
        
        addPopHandler(for: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
