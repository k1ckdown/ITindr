//
//  ProfileRepositoryAssembly.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network
import ProfileDomain

public struct ModuleDependencies {
    let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

public struct ProfileRepositoryAssembly {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble() -> ProfileRepositoryProtocol {
        let remoteDataSource = ProfileRemoteDataSource(networkService: dependencies.networkService)
        let repository = ProfileRepository(remoteDataSource: remoteDataSource)

        return repository
    }
}
