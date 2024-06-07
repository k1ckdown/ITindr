//
//  UserMatchCoordinatorAssembly.swift
//  UserMatch
//
//  Created by Ivan Semenov on 07.06.2024.
//

import SwiftUI
import Navigation
import UserMatchInterface

public struct UserMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(
        userId: String,
        cancelHandler: (() -> Void)?,
        navigationController: NavigationController
    ) -> UserMatchCoordinatorProtocol {
        let content: UserMatchCoordinator.Content = {
            let view = UserMatchView(cancelHandler: {})
            let hostingController = UIHostingController(rootView: view)
            hostingController.rootView = UserMatchView(cancelHandler: {
                hostingController.dismiss(animated: true)
                cancelHandler?()
            })
            
            return hostingController
        }

        return UserMatchCoordinator(content: content, navigationController: navigationController)
    }
}
