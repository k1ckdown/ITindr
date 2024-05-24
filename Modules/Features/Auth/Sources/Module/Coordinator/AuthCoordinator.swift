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
    private let flowFinishHandler: (() -> Void)?

    init(factory: CoordinatorFactory, flowFinishHandler: (() -> Void)?, navigationController: NavigationController) {
        self.factory = factory
        self.flowFinishHandler = flowFinishHandler
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
