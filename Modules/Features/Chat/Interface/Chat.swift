//
//  Chat.swift
//  ChatInterface
//
//  Created by Ivan Semenov on 07.06.2024.
//

public struct Chat: Equatable {
    public let id: String
    public let title: String
    public let avatarUrl: String?

    public init(id: String, title: String, avatarUrl: String?) {
        self.id = id
        self.title = title
        self.avatarUrl = avatarUrl
    }
}
