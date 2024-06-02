//
//  ChatDTO+Mapping.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

extension ChatDTO {
    
    func toDomain() -> Chat {
        Chat(id: id, title: title, avatar: avatar)
    }
}
