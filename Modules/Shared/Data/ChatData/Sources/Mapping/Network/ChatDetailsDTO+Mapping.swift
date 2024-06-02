//
//  ChatDetailsDTO+Mapping.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

extension [ChatDetailsDTO] {

    func toDomain() -> [ChatDetails] {
        map { $0.toDomain() }
    }
}

extension ChatDetailsDTO {

    func toDomain() -> ChatDetails {
        ChatDetails(chat: chat.toDomain(), lastMessage: lastMessage.toDomain())
    }
}
