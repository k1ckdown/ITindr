//
//  MessageSend.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Foundation

public struct MessageSend {
    public let chatId: String
    public let text: String
    public let attachments: [Data]

    public init(chatId: String, text: String, attachments: [Data]) {
        self.chatId = chatId
        self.text = text
        self.attachments = attachments
    }
}
