//
//  ChatDetails.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public struct ChatDetails: Equatable {
    public let chat: Chat
    public let lastMessage: Message

    public init(chat: Chat, lastMessage: Message) {
        self.chat = chat
        self.lastMessage = lastMessage
    }
}
