//
//  MessageDTO+Mapping.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

extension [MessageDTO] {
    
    func toDomain() -> [Message] {
        map { $0.toDomain() }
    }
}

extension MessageDTO {
    
    func toDomain() -> Message {
        Message(
            id: id,
            text: text,
            createdAt: createdAt,
            user: user.toDomain(),
            attachments: attachments
        )
    }
}
