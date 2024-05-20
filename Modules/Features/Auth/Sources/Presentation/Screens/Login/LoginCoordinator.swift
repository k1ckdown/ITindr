//
//  LoginCoordinator.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI
import Navigation

final class LoginCoordinator: BaseCoordinator {

    override func start() {
        let rootView = LoginScreen()
        let hostingController = UIHostingController(rootView: rootView)

        addPopHandler(for: hostingController)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
