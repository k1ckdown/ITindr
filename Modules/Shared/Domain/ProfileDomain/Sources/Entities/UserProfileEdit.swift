//
//  UserProfileEdit.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

import TopicDomain

public struct UserProfileEdit {
    public let name: String
    public let aboutMyself: String?
    public let topics: [Topic]
    
    public init(name: String, aboutMyself: String?, topics: [Topic]) {
        self.name = name
        self.aboutMyself = aboutMyself
        self.topics = topics
    }
}
