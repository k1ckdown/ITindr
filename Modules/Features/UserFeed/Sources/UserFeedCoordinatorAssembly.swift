//
//  UserFeedCoordinatorAssembly.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import UserFeedInterface

public struct UserFeedCoordinatorAssembly: UserFeedCoordinatorAssemblyProtocol {

    public init() {}

    public func assemble(navigationController: NavigationController) -> UserFeedCoordinatorProtocol {
        UserFeedCoordinator(navigationController: navigationController)
    }
}
