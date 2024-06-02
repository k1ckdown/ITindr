//
//  Chat.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public struct Chat {
    public let id: String
    public let title: String
    public let avatar: String?
    
    public init(id: String, title: String, avatar: String?) {
        self.id = id
        self.title = title
        self.avatar = avatar
    }
}
