//
//  AppFactory.swift
//  ITindr
//
//  Created by Ivan Semenov on 10.05.2024.
//

import Auth
import ProfileEditor
import AuthFlow
import ProfileData
import AuthData
import ProfileDomain
import AuthDomain
import Network
import Keychain
import Navigation

final class AppFactory {
    
    private lazy var authInterceptor = AuthInterceptor()
    private lazy var keychainStorage = KeychainStorage()
    private lazy var networkService = NetworkService(authInterceptor: authInterceptor)
    
    private lazy var profileRepository: ProfileRepositoryProtocol = {
        let dependencies = ProfileData.ModuleDependencies(networkService: networkService)
        return ProfileRepositoryAssembly(dependencies: dependencies).assemble()
    }()
    
    private lazy var authRepository: AuthRepositoryProtocol = {
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
    
    func makeAuthFlowCoordinatorAssembly() -> AuthFlowCoordinatorAssembly {
        let dependencies = AuthFlow.ModuleDependencies(
            authCoordinatorAssembly: makeAuthCoordinatorAssembly(),
            profileEditorCoordinatorAssembly: makeProfileEditorCoordinatorAssembly()
        )
        
        return AuthFlowCoordinatorAssembly(dependencies: dependencies)
    }
}

// MARK: - Private methods

@MainActor
private extension AppFactory {
    
    func makeAuthCoordinatorAssembly() -> AuthCoordinatorAssembly {
        let dependencies = Auth.ModuleDependencies(authRepository: authRepository)
        return AuthCoordinatorAssembly(dependencies: dependencies)
    }
    
    func makeProfileEditorCoordinatorAssembly() -> ProfileEditorCoordinatorAssembly {
        let dependencies = ProfileEditor.ModuleDependencies(profileRepository: profileRepository)
        return ProfileEditorCoordinatorAssembly(dependencies: dependencies)
    }
}
