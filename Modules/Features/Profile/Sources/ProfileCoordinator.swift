//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import ProfileInterface

final class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorProtocol {

    override func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red

        addPopHandler(for: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
