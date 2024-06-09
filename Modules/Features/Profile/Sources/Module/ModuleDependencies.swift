//
//  ModuleDependencies.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
//

import ProfileDomain
import ProfileEditorInterface

public struct ModuleDependencies {
    let profileRepository: ProfileRepositoryProtocol
    let profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol

    public init(profileRepository: ProfileRepositoryProtocol, profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol) {
        self.profileRepository = profileRepository
        self.profileEditorCoordinatorAssembly = profileEditorCoordinatorAssembly
    }
}
