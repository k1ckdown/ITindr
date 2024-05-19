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
    let navigationController: NavigationController

    public init(authRepository: AuthRepositoryProtocol, navigationController: NavigationController) {
        self.authRepository = authRepository
        self.navigationController = navigationController
    }
}
