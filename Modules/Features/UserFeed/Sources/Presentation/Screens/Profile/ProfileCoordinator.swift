//
//  ProfileCoordinator.swift
//  UserFeed
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UIKit
import Navigation

final class ProfileCoordinator: BaseCoordinator {
    typealias Content = () -> UIViewController

    private let content: Content

    init(content: @escaping Content, navigationController: NavigationController) {
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content()

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }
}
