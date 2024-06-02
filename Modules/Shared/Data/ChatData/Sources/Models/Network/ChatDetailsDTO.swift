//
//  ChatDetailsDTO.swift
//  ChatData
//
//  Created by Ivan Semenov on 02.06.2024.
//

struct ChatDetailsDTO: Decodable {
    let chat: ChatDTO
    let lastMessage: MessageDTO
}
