//
//  UserListCoordinatorAssembly.swift
//  UserList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import UserListInterface

public struct UserListCoordinatorAssembly: UserListCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> UserListCoordinatorProtocol {
        UserListCoordinator(navigationController: navigationController)
    }
}
