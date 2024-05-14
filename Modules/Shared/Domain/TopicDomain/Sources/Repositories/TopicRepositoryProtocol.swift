//
//  TopicRepositoryProtocol.swift
//  TopicDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

public protocol TopicRepositoryProtocol: AnyObject {
    func getAllTopics() async throws -> [Topic]
}
