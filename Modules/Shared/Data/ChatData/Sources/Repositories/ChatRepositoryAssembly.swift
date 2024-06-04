//
//  ChatRepositoryAssembly.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Network
import ChatDomain

public typealias UserIdProvider = () async throws -> String

public struct ModuleDependencies {
    let userIdProvider: UserIdProvider
    let networkService: NetworkServiceProtocol

    public init(userIdProvider: @escaping UserIdProvider, networkService: NetworkServiceProtocol) {
        self.userIdProvider = userIdProvider
        self.networkService = networkService
    }
}

public struct ChatRepositoryAssembly {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble() -> ChatRepositoryProtocol {
        let remoteDataSource = ChatRemoteDataSource(networkService: dependencies.networkService)
        let repository = ChatRepository(userIdProvider: dependencies.userIdProvider, remoteDataSource: remoteDataSource)

        return repository
    }
}
