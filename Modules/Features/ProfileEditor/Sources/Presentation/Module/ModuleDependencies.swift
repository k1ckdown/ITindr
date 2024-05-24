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

    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
}
