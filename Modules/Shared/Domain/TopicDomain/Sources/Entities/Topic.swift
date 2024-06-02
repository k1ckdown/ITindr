//
//  Topic.swift
//  TopicDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

public struct Topic: Equatable {
    public let id: String
    public let title: String

    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}
