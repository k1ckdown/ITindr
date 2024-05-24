//
//  ModuleDependencies.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import Navigation
import ProfileDomain

public struct ModuleDependencies {
    let profileRepository: ProfileRepositoryProtocol
    let navigationController: NavigationController

    public init(profileRepository: ProfileRepositoryProtocol, navigationController: NavigationController) {
        self.profileRepository = profileRepository
        self.navigationController = navigationController
    }
}
