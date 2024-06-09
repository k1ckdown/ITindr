//
//  CoordinatorFactory.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI
import Navigation
import ProfileDomain
import UserMatchInterface

final class CoordinatorFactory {

    private let screenFactory: ScreenFactory
    private let userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol

    init(screenFactory: ScreenFactory, userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol) {
        self.screenFactory = screenFactory
        self.userMatchCoordinatorAssembly = userMatchCoordinatorAssembly
    }
}

@MainActor
extension CoordinatorFactory {

    func makeProfileCoordinator(user: UserProfile, navigationController: NavigationController) -> ProfileCoordinator {
        let content: ProfileCoordinator.Content = {
            let screen = self.screenFactory.makeProfileScreen(user: user)
            return UIHostingController(rootView: screen)
        }

        return ProfileCoordinator(content: content, navigationController: navigationController)
    }

    func makeFeedCoordinator(navigationController: NavigationController) -> UserFeedCoordinator {
        let content: UserFeedCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeFeedScreen(middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        return UserFeedCoordinator(
            content: content,
            factory: self,
            navigationController: navigationController,
            userMatchCoordinatorAssembly: userMatchCoordinatorAssembly
        )
    }
}
