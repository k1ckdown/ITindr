//
//  CoordinatorFactory.swift
//  UserList
//
//  Created by Ivan Semenov on 08.06.2024.
//

import SwiftUI
import Navigation
import ProfileDomain

final class CoordinatorFactory {

    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }
}

// MARK: - UserListCoordinatorFactory

extension CoordinatorFactory: UserListCoordinatorFactory {
    func makeUserListCoordinator(navigationController: NavigationController) -> UserListCoordinator {
        UserListCoordinator(content: screenFactory.makeUserListScreen, factory: self, navigationController: navigationController)
    }
}

// MARK: - ProfileCoordinatorFactory

extension CoordinatorFactory: ProfileCoordinatorFactory {
    func makeProfileCoordinator(profile: UserProfile, navigationController: NavigationController) -> ProfileCoordinator {
        let content: ProfileCoordinator.Content = { middlewareDelegate in
            let screen = self.screenFactory.makeProfileScreen(profile: profile, middlewareDelegate: middlewareDelegate)
            return UIHostingController(rootView: screen)
        }

        return ProfileCoordinator(content: content, navigationController: navigationController)
    }
}
