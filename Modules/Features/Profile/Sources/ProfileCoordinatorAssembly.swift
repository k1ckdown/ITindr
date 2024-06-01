//
//  ProfileCoordinatorAssembly.swift
//  Profile
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import ProfileInterface

public struct ProfileCoordinatorAssembly: ProfileCoordinatorAssemblyProtocol {

    public init() {}

    public func assemble(navigationController: NavigationController) -> ProfileCoordinatorProtocol {
        ProfileCoordinator(navigationController: navigationController)
    }
}
