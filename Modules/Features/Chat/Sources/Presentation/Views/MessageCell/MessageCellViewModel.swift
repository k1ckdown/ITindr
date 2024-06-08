//
//  MessageCellViewModel.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import Foundation

struct MessageCellViewModel: Equatable {
    let id: String
    let text: String?
    let avatar: String?
    let imageUrl: String?
    let createdAt: Date
    let isOutgoing: Bool
}
