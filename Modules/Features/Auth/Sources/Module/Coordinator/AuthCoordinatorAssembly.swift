//
//  AuthCoordinatorAssembly.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 20.05.2024.
//

import AuthInterface
import Navigation

public struct AuthCoordinatorAssembly: AuthCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(flowFinishHandler: (() -> Void)?) -> AuthCoordinatorProtocol {
        let useCaseFactory = UseCaseFactory(authRepository: dependencies.authRepository)
        let screenFactory = ScreenFactory(useCaseFactory: useCaseFactory)
        let coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory, flowFinishHandler: flowFinishHandler)

        let coordinator = AuthCoordinator(
            factory: coordinatorFactory,
            flowFinishHandler: flowFinishHandler,
            navigationController: dependencies.navigationController
        )
        return coordinator
    }
}
