//
//  Message.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Foundation

public struct Message {
    public let id: String
    public let text: String
    public let createdAt: Date
    public let user: User
    public let attachments: [Data]

    public init(id: String, text: String, createdAt: Date, user: User, attachments: [Data]) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.user = user
        self.attachments = attachments
    }
}
