//
//  UserRepositoryAssembly.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Network
import ProfileDomain

public struct ModuleDependencies {
    let networkService: NetworkServiceProtocol
    
    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

public struct UserRepositoryAssembly {
    
    private let dependencies: ModuleDependencies
    
    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }
    
    public func assemble() -> UserRepositoryProtocol {
        let localDataSource = UserLocalDataSource()
        let remoteDataSource = UserRemoteDataSource(networkService: dependencies.networkService)
        let repository = UserRepository(localDataSource: localDataSource, remoteDataSource: remoteDataSource)

        return repository
    }
}
