//
//  AppFactory.swift
//  ITindr
//
//  Created by Ivan Semenov on 10.05.2024.
//

import Network
import Keychain
import AuthData

final class AppFactory {

    private lazy var authInterceptor = AuthInterceptor()
    private lazy var keychainStorage = KeychainStorage()
    private lazy var networkService = NetworkService(authInterceptor: authInterceptor)

    private lazy var authRepository: AuthRepository = {
        let repository = AuthRepository(
            networkService: networkService,
            authCredentialsStorage: keychainStorage
        )

        authInterceptor.delegate = repository
        return repository
    }()
}
