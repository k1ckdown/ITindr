//
//  ChatDetailsDTO+Mapping.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

extension ChatDetailsDTO {

    func toDomain(lastMessageIsOutgoing: Bool) -> ChatDetails {
        ChatDetails(chat: chat.toDomain(), lastMessage: lastMessage?.toDomain(isOutgoing: lastMessageIsOutgoing))
    }
}
