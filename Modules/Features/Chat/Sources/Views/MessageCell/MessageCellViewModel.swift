//
//  MessageCellViewModel.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import Foundation

final class MessageCellViewModel {

    private(set) var text: String?
    private(set) var avatar: String?
    private(set) var createdAt: Date
    private(set) var isOutgoing: Bool

    init(text: String?, avatar: String?, createdAt: Date, isAuthor: Bool) {
        self.text = text
        self.avatar = avatar
        self.createdAt = createdAt
        self.isOutgoing = isAuthor
    }
}

extension MessageCellViewModel {

    static let mock: [MessageCellViewModel] = [
        .init(text: "Открыл", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false),
        .init(text: "Открыл тебе доступ к своему приватному", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: true),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: true),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false),
        .init(text: "Открыл тебе доступ", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: true),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: true),
        .init(text: "Открыл тебе доступ", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false),
        .init(text: "Открыл тебе доступ к своему приватному репо. Скоро закрою 🥴", avatar: "https://versiya.info/uploads/posts/2019-03/1552587088_unnamed.jpg", createdAt: .now, isAuthor: false)
    ]
}
