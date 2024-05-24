//
//  LoginCoordinator.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI
import Navigation

final class LoginCoordinator: BaseCoordinator {
    typealias Factory = RegistrationCoordinatorFactory
    typealias Content = (LoginMiddlewareDelegate) -> UIViewController

    private let factory: Factory
    private let content: Content
    private let loginFinishedHandler: (() -> Void)?

    init(content: @escaping Content, factory: Factory, loginFinishedHandler: (() -> Void)?, navigationController: NavigationController) {
        self.content = content
        self.factory = factory
        self.loginFinishedHandler = loginFinishedHandler
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - LoginMiddlewareDelegate

extension LoginCoordinator: LoginMiddlewareDelegate {

    func finish() {
        loginFinishedHandler?()
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
