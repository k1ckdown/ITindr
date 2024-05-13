//
//  TopicRepository.swift
//  TopicDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

public protocol TopicRepository: AnyObject {
    func getAllTopics() async throws -> [Topic]
}
