//
//  User.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public struct User {
    public let id: String
    public let name: String
    public let avatar: String?
    public let aboutMyself: String?
    
    public init(id: String, name: String, avatar: String?, aboutMyself: String?) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.aboutMyself = aboutMyself
    }
}
