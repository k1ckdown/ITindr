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
    typealias Content = (RegistrationMiddlewareDelegate) -> UIViewController

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
        navigationController.pushViewController(content, animated: true)
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
