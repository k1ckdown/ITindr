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

    public func assemble(
        navigationController: NavigationController,
        loginFinishedHandler: (() -> Void)?,
        registrationFinishedHandler: (() -> Void)?
    ) -> AuthCoordinatorProtocol {
        let useCaseFactory = UseCaseFactory(authRepository: dependencies.authRepository)
        let screenFactory = ScreenFactory(useCaseFactory: useCaseFactory)
        let coordinatorFactory = CoordinatorFactory(
            screenFactory: screenFactory,
            loginFinishedHandler: loginFinishedHandler,
            registrationFinishedHandler: registrationFinishedHandler
        )


        return AuthCoordinator(
            factory: coordinatorFactory,
            navigationController: navigationController
        )
    }
}
