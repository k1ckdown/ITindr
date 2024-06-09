//
//  AppCoordinator.swift
//  ITindr
//
//  Created by Ivan Semenov on 20.05.2024.
//

import CommonUI
import Navigation

final class AppCoordinator: BaseCoordinator {
    
    private let isLoggedIn: Bool
    private let appFactory: AppFactory
    
    init(appFactory: AppFactory, isLoggedIn: Bool, navigationController: NavigationController) {
        self.appFactory = appFactory
        self.isLoggedIn = isLoggedIn
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        isLoggedIn ? goToMainTabBar() : goToAuthFlow()
    }
}

// MARK: - Public methods

extension AppCoordinator {
    
    func goToAuthFlow() {
        resetNavigation()
        
        let authFlowCoordinator = appFactory.makeAuthFlowCoordinatorAssembly().assemble(
            navigationController: navigationController,
            flowFinishHandler: goToMainTabBar
        )
        coordinate(to: authFlowCoordinator)
    }
}

// MARK: - Private methods

private extension AppCoordinator {
    
    func goToMainTabBar() {
        resetNavigation()
        
        let mainTabBarCoordinator = appFactory.makeMainTabBarCoordinatorAssembly().assemble(
            navigationController: navigationController
        )
        coordinate(to: mainTabBarCoordinator)
    }
    
    func resetNavigation() {
        removeChildCoordinators()
        navigationController.dismiss(animated: false)
        navigationController.removeAllPopHandlers()
        navigationController.viewControllers.removeAll()
    }
}
