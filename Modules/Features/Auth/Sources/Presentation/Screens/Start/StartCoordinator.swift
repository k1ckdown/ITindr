//
//  StartCoordinator.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit
import SwiftUI
import Navigation

final class StartCoordinator: BaseCoordinator {
    typealias Factory = RegistrationCoordinatorFactory

    private let factory: Factory
    private let content: (StartMiddlewareDelegate) -> UIViewController

    init(
        factory: Factory,
        navigationController: NavigationController,
        content: @escaping (StartMiddlewareDelegate) -> UIViewController
    ) {
        self.factory = factory
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        setupPopHandler(for: content)
        navigationController.setViewControllers([content], animated: false)
    }
}

// MARK: - StartMiddlewareDelegate

extension StartCoordinator: StartMiddlewareDelegate {

    func showLogin() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }

    func showRegistration() {
        let coordinator = factory.makeRegistrationCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
