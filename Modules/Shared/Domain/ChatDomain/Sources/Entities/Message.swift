//
//  Message.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Foundation

public struct Message: Equatable {
    public let id: String
    public let text: String?
    public let createdAt: Date
    public let user: User
    public let isOutgoing: Bool
    public let attachments: [String]

    public init(id: String, text: String?, createdAt: Date, user: User, isOutgoing: Bool, attachments: [String]) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.user = user
        self.isOutgoing = isOutgoing
        self.attachments = attachments
    }
}
