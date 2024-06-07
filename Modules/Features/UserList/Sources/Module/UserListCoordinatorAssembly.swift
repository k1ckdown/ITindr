//
//  UserListCoordinatorAssembly.swift
//  UserList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import Navigation
import UserListInterface

public struct UserListCoordinatorAssembly: UserListCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> UserListCoordinatorProtocol {
        let useCaseFactory = UseCaseFactory(userRepository: dependencies.userRepository)
        let screenFactory = ScreenFactory(useCaseFactory: useCaseFactory)
        let coordinatorFactory = CoordinatorFactory(
            screenFactory: screenFactory,
            userMatchCoordinatorAssembly: dependencies.userMatchCoordinatorAssembly
        )

        return coordinatorFactory.makeUserListCoordinator(navigationController: navigationController)
    }
}
