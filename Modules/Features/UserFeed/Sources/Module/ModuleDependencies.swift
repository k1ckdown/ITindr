//
//  ModuleDependencies.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain
import UserMatchInterface

public struct ModuleDependencies {
    let userRepository: UserRepositoryProtocol
    let userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol

    public init(userRepository: UserRepositoryProtocol, userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol) {
        self.userRepository = userRepository
        self.userMatchCoordinatorAssembly = userMatchCoordinatorAssembly
    }
}
