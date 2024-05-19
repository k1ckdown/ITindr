//
//  AuthCoordinator.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI
import Navigation
import AuthInterface

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorProtocol {

    private let factory: CoordinatorFactory

    init(factory: CoordinatorFactory, navigationController: NavigationController) {
        self.factory = factory
        super.init(navigationController: navigationController)
    }

    override func start() {
        showStart()
    }
}

// MARK: - Private methods

private extension AuthCoordinator {

    func showStart() {
        let startCoordinator = factory.makeStartCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
