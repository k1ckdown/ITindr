//
//  CoordinatorFactory.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI
import Navigation
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
