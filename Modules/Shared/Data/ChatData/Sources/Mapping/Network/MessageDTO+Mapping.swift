//
//  MessageDTO+Mapping.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

extension MessageDTO {
    
    func toDomain(isOutgoing: Bool) -> Message {
        Message(
            id: id,
            text: text,
            createdAt: createdAt,
            user: user.toDomain(),
            isOutgoing: isOutgoing,
            attachments: attachments
        )
    }
}
