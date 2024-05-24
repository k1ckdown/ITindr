//
//  CoordinatorFactory.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI
import Navigation

final class CoordinatorFactory {
    
    private let screenFactory: ScreenFactory
    private let loginFinishedHandler: (() -> Void)?
    private let registrationFinishedHandler: (() -> Void)?
    
    init(screenFactory: ScreenFactory, loginFinishedHandler: (() -> Void)?, registrationFinishedHandler: (() -> Void)?) {
        self.screenFactory = screenFactory
        self.loginFinishedHandler = loginFinishedHandler
        self.registrationFinishedHandler = registrationFinishedHandler
    }
}

// MARK: StartCoordinatorFactory

extension CoordinatorFactory: StartCoordinatorFactory {
    func makeStartCoordinator(navigationController: NavigationController) -> StartCoordinator {
        let content: StartCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeStartScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }
        
        return StartCoordinator(factory: self, navigationController: navigationController, content: content)
    }
}

// MARK: - LoginCoordinatorFactory

extension CoordinatorFactory: LoginCoordinatorFactory {
    func makeLoginCoordinator(navigationController: NavigationController) -> LoginCoordinator {
        let content: LoginCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeLoginScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }
        
        return LoginCoordinator(
            content: content,
            factory: self,
            loginFinishedHandler: loginFinishedHandler,
            navigationController: navigationController
        )
    }
}

// MARK: RegistrationCoordinatorFactory

extension CoordinatorFactory: RegistrationCoordinatorFactory {
    func makeRegistrationCoordinator(navigationController: NavigationController) -> RegistrationCoordinator {
        let content: RegistrationCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeRegistrationScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }
        
        return RegistrationCoordinator(
            content: content,
            factory: self,
            registrationFinishedHandler: registrationFinishedHandler,
            navigationController: navigationController
        )
    }
}
