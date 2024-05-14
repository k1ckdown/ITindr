//
//  TopicRepository.swift
//  TopicData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import TopicDomain

final class TopicRepository {

    private let remoteDataSource: TopicRemoteDataSource

    init(remoteDataSource: TopicRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - TopicRepositoryProtocol

extension TopicRepository: TopicRepositoryProtocol {

    func getAllTopics() async throws -> [Topic] {
        let remotePosts = try await remoteDataSource.fetchAllTopics()
        return remotePosts.toDomain()
    }
}

