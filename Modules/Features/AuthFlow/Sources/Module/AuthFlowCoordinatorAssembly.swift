//
//  AuthFlowCoordinatorAssembly.swift
//  AuthFlow
//
//  Created by Ivan Semenov on 25.05.2024.
//

import Navigation
import AuthFlowInterface

public struct AuthFlowCoordinatorAssembly: AuthFlowCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController, flowFinishHandler: (() -> Void)?) -> AuthFlowCoordinatorProtocol {
        AuthFlowCoordinator(
            flowFinishHandler: flowFinishHandler,
            authCoordinatorAssembly: dependencies.authCoordinatorAssembly,
            profileEditorCoordinatorAssembly: dependencies.profileEditorCoordinatorAssembly,
            navigationController: navigationController
        )
    }
}
