//
//  RegistrationCoordinator.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI
import Navigation

final class RegistrationCoordinator: BaseCoordinator {
    typealias Factory = RegistrationCoordinatorFactory

    private let factory: Factory
    private let content: (RegistrationMiddlewareDelegate) -> UIViewController

    init(
        factory: Factory,
        navigationController: NavigationController,
        content: @escaping (RegistrationMiddlewareDelegate) -> UIViewController
    ) {
        self.factory = factory
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        setupPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - RegistrationMiddlewareDelegate

extension RegistrationCoordinator: RegistrationMiddlewareDelegate {

    func goBack() {
        navigationController.popViewController(animated: true)
    }

    func showProfileEditor() {

    }
}
