//
//  Profile.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 09.06.2024.
//

public struct Profile {
    public let id: String
    public let name: String
    public let avatarUrl: String?
    public let aboutMyself: String?
    public let topics: [Topic]

    public init(id: String, name: String, avatarUrl: String?, aboutMyself: String?, topics: [Topic]) {
        self.id = id
        self.name = name
        self.avatarUrl = avatarUrl
        self.aboutMyself = aboutMyself
        self.topics = topics
    }
}

public extension Profile {
    static let empty = Profile(id: "", name: "", avatarUrl: nil, aboutMyself: nil, topics: [])
}
