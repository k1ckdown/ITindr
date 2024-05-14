//
//  AuthRepositoryAssembly.swift
//  AuthData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import AuthDomain
import Keychain
import Network

public struct ModuleDependencies {
    let keychainStorage: KeychainStorage
    let networkService: NetworkServiceProtocol

    public init(keychainStorage: KeychainStorage, networkService: NetworkServiceProtocol) {
        self.keychainStorage = keychainStorage
        self.networkService = networkService
    }
}

public struct AuthRepositoryAssembly {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble() -> AuthRepositoryProtocol {
        let repository = AuthRepository(
            networkService: dependencies.networkService,
            credentialsLocalDataSource: dependencies.keychainStorage
        )

        return repository
    }
}
