//
//  UserProfile.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

import Foundation
import TopicDomain

public struct UserProfile: Equatable {
    public let id: String
    public let name: String
    public let avatarData: Data?
    public let avatarUrl: String?
    public let aboutMyself: String?
    public let topics: [Topic]
    
    public init(id: String, name: String, avatarUrl: String?, aboutMyself: String?, topics: [Topic], avatarData: Data? = nil) {
        self.id = id
        self.name = name
        self.avatarUrl = avatarUrl
        self.aboutMyself = aboutMyself
        self.topics = topics
        self.avatarData = avatarData
    }
}
