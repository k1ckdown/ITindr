//
//  TopicRemoteDataSource.swift
//  TopicData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network

final class TopicRemoteDataSource {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Public methods

extension TopicRemoteDataSource {

    func fetchAllTopics() async throws -> [TopicDTO] {
        let networkConfig = TopicNetworkConfig.list
        return try await networkService.request(config: networkConfig, authorized: true)
    }
}
