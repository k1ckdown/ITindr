//
//  UserFeedCoordinatorAssembly.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import UserFeedInterface

public struct UserFeedCoordinatorAssembly: UserFeedCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> UserFeedCoordinatorProtocol {
        let useCaseFactory = UseCaseFactory(userRepository: dependencies.userRepository)
        let screenFactory = ScreenFactory(useCaseFactory: useCaseFactory)
        let coordinatorFactory = CoordinatorFactory(
            screenFactory: screenFactory,
            userMatchCoordinatorAssembly: dependencies.userMatchCoordinatorAssembly
        )

        return coordinatorFactory.makeFeedCoordinator(navigationController: navigationController)
    }
}
