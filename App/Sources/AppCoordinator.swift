//
//  AppCoordinator.swift
//  ITindr
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Auth
import Navigation

final class AppCoordinator: BaseCoordinator {
    
    private let appFactory = AppFactory()
    
    override func start() {
        showAuth()
    }
}

// MARK: - Private methods

private extension AppCoordinator {
    
    func showAuth() {
        let authCoordinator = appFactory.makeAuthCoordinator(navigationController: navigationController)
        coordinate(to: authCoordinator)
    }
    
    func resetNavigation() {
        removeChildCoordinators()
        navigationController.dismiss(animated: false)
        navigationController.viewControllers.removeAll()
    }
}
