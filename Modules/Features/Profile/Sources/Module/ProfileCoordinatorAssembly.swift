//
//  ProfileCoordinatorAssembly.swift
//  Profile
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI
import Navigation
import ProfileInterface

public struct ProfileCoordinatorAssembly: ProfileCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> ProfileCoordinatorProtocol {
        let content: ProfileCoordinator.Content = { middlewareDelegate in
            let screen = ProfileScreen()
            return UIHostingController(rootView: screen)
        }

        return ProfileCoordinator(
            content: content,
            navigationController: navigationController,
            profileEditorCoordinatorAssembly: dependencies.profileEditorCoordinatorAssembly
        )
    }
}
