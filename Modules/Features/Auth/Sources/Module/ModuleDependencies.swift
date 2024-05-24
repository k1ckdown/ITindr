//
//  ModuleDependencies.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import AuthDomain
import Navigation

public struct ModuleDependencies {
    let authRepository: AuthRepositoryProtocol

    public init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
}
