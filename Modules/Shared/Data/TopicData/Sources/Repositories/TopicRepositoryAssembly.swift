//
//  TopicRepositoryAssembly.swift
//  TopicData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network
import TopicDomain

public struct ModuleDependencies {
    let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

public struct TopicRepositoryAssembly {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble() -> TopicRepositoryProtocol {
        let remoteDataSource = TopicRemoteDataSource(networkService: dependencies.networkService)
        let repository = TopicRepository(remoteDataSource: remoteDataSource)

        return repository
    }
}
