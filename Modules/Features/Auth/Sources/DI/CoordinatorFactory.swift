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

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }
}

// MARK: RegistrationCoordinatorFactory

extension CoordinatorFactory: RegistrationCoordinatorFactory {
    func makeRegistrationCoordinator(navigationController: NavigationController) -> RegistrationCoordinator {
        let content: RegistrationCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeRegistrationScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        let coordinator = RegistrationCoordinator(factory: self, navigationController: navigationController, content: content)
        return coordinator
    }
}

// MARK: StartCoordinatorFactory

extension CoordinatorFactory: StartCoordinatorFactory {
    func makeStartCoordinator(navigationController: NavigationController) -> StartCoordinator {
        let content: StartCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeStartScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        let coordinator = StartCoordinator(factory: self, navigationController: navigationController, content: content)
        return coordinator
    }
}
