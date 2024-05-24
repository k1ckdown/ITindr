//
//  AuthCoordinatorAssembly.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Navigation
import AuthInterface

public struct AuthCoordinatorAssembly: AuthCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController, flowFinishHandler: (() -> Void)?) -> AuthCoordinatorProtocol {
        let useCaseFactory = UseCaseFactory(authRepository: dependencies.authRepository)
        let screenFactory = ScreenFactory(useCaseFactory: useCaseFactory)
        let coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory, flowFinishHandler: flowFinishHandler)

        let coordinator = AuthCoordinator(
            factory: coordinatorFactory,
            flowFinishHandler: flowFinishHandler,
            navigationController: navigationController
        )
        return coordinator
    }
}
