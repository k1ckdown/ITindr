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
    typealias Content = (UserListMiddlewareDelegate) -> UIViewController
    
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

// MARK: - UserListMiddlewareDelegate

extension UserListCoordinator: UserListMiddlewareDelegate {
    
    func goToProfile(_ profile: UserProfile) {
        print(profile.name)
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemIndigo
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
