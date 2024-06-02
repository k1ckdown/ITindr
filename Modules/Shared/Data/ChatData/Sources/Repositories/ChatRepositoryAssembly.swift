//
//  ChatRepositoryAssembly.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Network
import ChatDomain

public struct ModuleDependencies {
    let networkService: NetworkServiceProtocol
    
    public init(networkService: NetworkServiceProtocol) {
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
        let repository = ChatRepository(remoteDataSource: remoteDataSource)
        
        return repository
    }
}
