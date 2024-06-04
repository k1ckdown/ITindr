//
//  MessageDTO.swift
//  ChatData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Foundation

struct MessageDTO: Decodable {
    let id: String
    let text: String?
    let createdAt: Date
    let user: UserDTO
    let attachments: [String]
}
