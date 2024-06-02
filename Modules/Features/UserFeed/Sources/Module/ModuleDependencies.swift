//
//  ModuleDependencies.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

public struct ModuleDependencies {
    let userRepository: UserRepositoryProtocol

    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
}
