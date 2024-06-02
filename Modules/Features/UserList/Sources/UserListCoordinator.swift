//
//  UserListCoordinator.swift
//  UserList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import UserListInterface

final class UserListCoordinator: BaseCoordinator, UserListCoordinatorProtocol {

    override func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemIndigo

        addPopHandler(for: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
