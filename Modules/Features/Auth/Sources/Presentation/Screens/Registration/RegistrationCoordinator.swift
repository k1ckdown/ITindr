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
    private let flowFinishHandler: (() -> Void)?

    init(content: @escaping Content, factory: Factory, flowFinishHandler: (() -> Void)?, navigationController: NavigationController) {
        self.content = content
        self.factory = factory
        self.flowFinishHandler = flowFinishHandler
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
        print("Profile Editor")
    }
}
