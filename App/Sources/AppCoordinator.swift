//
//  AppCoordinator.swift
//  ITindr
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Navigation

final class AppCoordinator: BaseCoordinator {

    private let appFactory = AppFactory()

    override func start() {
        goToAuthFlow()
    }
}

// MARK: - Private methods

private extension AppCoordinator {

    func goToMainTabBar() {
        print("Main Tab Bar")
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
