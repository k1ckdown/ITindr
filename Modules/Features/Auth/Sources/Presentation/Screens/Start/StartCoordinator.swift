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
    typealias Factory = RegistrationCoordinatorFactory & LoginCoordinatorFactory
    typealias Content = (StartMiddlewareDelegate) -> UIViewController

    private let factory: Factory
    private let content: Content

    init(
        factory: Factory,
        navigationController: NavigationController,
        content: @escaping Content
    ) {
        self.factory = factory
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: false)
    }
}

// MARK: - StartMiddlewareDelegate

extension StartCoordinator: StartMiddlewareDelegate {

    func showLogin() {
        let coordinator = factory.makeLoginCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }

    func showRegistration() {
        let coordinator = factory.makeRegistrationCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
