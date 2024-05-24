//
//  AppFactory.swift
//  ITindr
//
//  Created by Ivan Semenov on 10.05.2024.
//

import Auth
import AuthInterface
import AuthData
import Network
import Keychain
import Navigation

final class AppFactory {

    private lazy var authInterceptor = AuthInterceptor()
    private lazy var keychainStorage = KeychainStorage()
    private lazy var networkService = NetworkService(authInterceptor: authInterceptor)

    private lazy var authRepository: AuthRepository = {
        let repository = AuthRepository(
            networkService: networkService,
            credentialsLocalDataSource: keychainStorage
        )

        authInterceptor.delegate = repository
        return repository
    }()
}

// MARK: - Public methods

@MainActor
extension AppFactory {

    func makeAuthCoordinator(navigationController: NavigationController) -> AuthCoordinatorProtocol {
        let dependencies = Auth.ModuleDependencies(authRepository: authRepository)
        let assembly = AuthCoordinatorAssembly(dependencies: dependencies)

        return assembly.assemble(navigationController: navigationController, flowFinishHandler: nil)
    }
}
