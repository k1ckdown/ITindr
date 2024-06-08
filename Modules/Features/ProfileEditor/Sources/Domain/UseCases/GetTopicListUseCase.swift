//
//  GetTopicListUseCase.swift
//  ProfileEditorInterface
//
//  Created by Ivan Semenov on 08.06.2024.
//

import TopicDomain

final class GetTopicListUseCase {

    private let topicRepository: TopicRepositoryProtocol

    init(topicRepository: TopicRepositoryProtocol) {
        self.topicRepository = topicRepository
    }

    func execute() async throws -> [Topic] {
        try await topicRepository.getAllTopics()
    }
}
