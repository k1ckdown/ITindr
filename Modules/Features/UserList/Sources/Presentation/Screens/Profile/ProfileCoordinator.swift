//
//  ProfileCoordinator.swift
//  UserList
//
//  Created by Ivan Semenov on 08.06.2024.
//

import UIKit
import Navigation
import ProfileDomain
import UserMatchInterface

final class ProfileCoordinator: BaseCoordinator {
    typealias Content = (ProfileMiddlewareDelegate) -> UIViewController
    
    private let content: Content
    private let userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol
    
    init(
        content: @escaping Content,
        navigationController: NavigationController,
        userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol
    ) {
        self.content = content
        self.userMatchCoordinatorAssembly = userMatchCoordinatorAssembly
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let content = content(self)
        
        addPopHandler(for: content)
        // TODO: Localize
        content.navigationItem.title = "Profile"
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - ProfileMiddlewareDelegate

extension ProfileCoordinator: ProfileMiddlewareDelegate {
    
    func goToBack() {
        navigationController.popViewController(animated: true)
    }
    
    func showUserMatch(userId: String) {
        let userMatchCoordinator = userMatchCoordinatorAssembly.assemble(
            userId: userId,
            cancelHandler: nil,
            navigationController: navigationController
        )
        
        userMatchCoordinator.present()
    }
}
