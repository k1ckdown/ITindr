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
    public let topics: [String]
    
    public init(name: String, aboutMyself: String?, topics: [String]) {
        self.name = name
        self.aboutMyself = aboutMyself
        self.topics = topics
    }
}
