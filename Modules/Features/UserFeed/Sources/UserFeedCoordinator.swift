//
//  UserFeedCoordinator.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import UserFeedInterface

final class UserFeedCoordinator: BaseCoordinator, UserFeedCoordinatorProtocol {

    override func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .green

        addPopHandler(for: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
