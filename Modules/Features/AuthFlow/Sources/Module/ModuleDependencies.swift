//
//  ModuleDependencies.swift
//  AuthFlow
//
//  Created by Ivan Semenov on 25.05.2024.
//

import Navigation
import AuthInterface
import ProfileEditorInterface

public struct ModuleDependencies {
    let authCoordinatorAssembly: AuthCoordinatorAssemblyProtocol
    let profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol

    public init(
        authCoordinatorAssembly: AuthCoordinatorAssemblyProtocol,
        profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol
    ) {
        self.authCoordinatorAssembly = authCoordinatorAssembly
        self.profileEditorCoordinatorAssembly = profileEditorCoordinatorAssembly
    }
}
