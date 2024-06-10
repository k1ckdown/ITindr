//
//  UserListCoordinator.swift
//  UserList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import ProfileDomain
import UserListInterface

final class UserListCoordinator: BaseCoordinator, UserListCoordinatorProtocol {
    typealias Factory = ProfileCoordinatorFactory
    typealias Content = (UserListMiddlewareDelegate) -> UIViewController

    private let content: Content
    private let factory: Factory

    init(content: @escaping Content, factory: Factory, navigationController: NavigationController) {
        self.content = content
        self.factory = factory
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        // TODO: Localize
        content.navigationItem.title = "Users"
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - UserListMiddlewareDelegate

extension UserListCoordinator: UserListMiddlewareDelegate {
    
    func goToProfile(_ profile: UserProfile) {
        let profileCoordinator = factory.makeProfileCoordinator(profile: profile, navigationController: navigationController)
        coordinate(to: profileCoordinator)
    }
}
