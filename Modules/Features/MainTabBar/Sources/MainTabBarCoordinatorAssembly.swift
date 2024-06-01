//
//  MainTabBarCoordinatorAssembly.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import MainTabBarInterface

public struct MainTabBarCoordinatorAssembly: MainTabBarCoordinatorAssemblyProtocol {

    public init() {}

    public func assemble(navigationController: NavigationController) -> MainTabBarCoordinatorProtocol {
        MainTabBarCoordinator(navigationController: navigationController)
    }
}
