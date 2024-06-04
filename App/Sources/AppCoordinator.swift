//
//  AppCoordinator.swift
//  ITindr
//
//  Created by Ivan Semenov on 20.05.2024.
//

import CommonUI
import Navigation

final class AppCoordinator: BaseCoordinator {

    private let appFactory = AppFactory()

    override func start() {
        coordinate(to: appFactory.makeChatCoordinatorAssembly().assemble(navigationController: navigationController))
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

    func goToAuthFlow() {
        resetNavigation()

        let authFlowCoordinator = appFactory.makeAuthFlowCoordinatorAssembly().assemble(
            navigationController: navigationController,
            flowFinishHandler: goToMainTabBar
        )
        coordinate(to: authFlowCoordinator)
    }

    func resetNavigation() {
        removeChildCoordinators()
        navigationController.dismiss(animated: false)
        navigationController.removeAllPopHandlers()
        navigationController.viewControllers.removeAll()
    }
}
