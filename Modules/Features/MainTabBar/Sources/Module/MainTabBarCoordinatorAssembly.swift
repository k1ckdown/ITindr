//
//  MainTabBarCoordinatorAssembly.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import MainTabBarInterface

public struct MainTabBarCoordinatorAssembly: MainTabBarCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> MainTabBarCoordinatorProtocol {
        MainTabBarCoordinator(
            navigationController: navigationController,
            profileCoordinatorAssembly: dependencies.profileCoordinatorAssembly,
            chatListCoordinatorAssembly: dependencies.chatListCoordinatorAssembly,
            userFeedCoordinatorAssembly: dependencies.userFeedCoordinatorAssembly,
            userListCoordinatorAssembly: dependencies.userListCoordinatorAssembly
        )
    }
}
