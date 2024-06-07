//
//  ProfileCoordinator.swift
//  UserList
//
//  Created by Ivan Semenov on 08.06.2024.
//

import UIKit
import Navigation
import ProfileDomain

final class ProfileCoordinator: BaseCoordinator {
    typealias Content = (ProfileMiddlewareDelegate) -> UIViewController

    private let content: Content

    init(content: @escaping Content, navigationController: NavigationController) {
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        content.navigationItem.title = "Profile"
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - ProfileMiddlewareDelegate

extension ProfileCoordinator: ProfileMiddlewareDelegate {

    func goToBack() {
        navigationController.popViewController(animated: true)
    }
}
