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
        let content: UserListCoordinator.Content = { middlewareDelegate in
            let reducer = UserListReducer()
            let middleware = UserListMiddleware(
                getUserListUseCase: .init(userRepository: dependencies.userRepository),
                delegate: middlewareDelegate
            )

            let store = Store(initialState: .idle, reducer: reducer, middleware: middleware)
            return UserListViewController(with: .init())
        }

        return UserListCoordinator(content: content, navigationController: navigationController)
    }
}
