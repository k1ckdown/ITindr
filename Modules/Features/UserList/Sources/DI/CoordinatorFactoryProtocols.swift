//
//  CoordinatorFactoryProtocols.swift
//  UserList
//
//  Created by Ivan Semenov on 08.06.2024.
//

import Navigation
import ProfileDomain

@MainActor
protocol UserListCoordinatorFactory {
    func makeUserListCoordinator(navigationController: NavigationController) -> UserListCoordinator
}

@MainActor
protocol ProfileCoordinatorFactory {
    func makeProfileCoordinator(profile: UserProfile, navigationController: NavigationController) -> ProfileCoordinator
}
