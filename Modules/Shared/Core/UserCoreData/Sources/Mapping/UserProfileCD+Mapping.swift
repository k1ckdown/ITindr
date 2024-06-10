//
//  UserProfileCD+Mapping.swift
//  UserData
//
//  Created by Ivan Semenov on 10.06.2024.
//

import CoreData
import ProfileDomain

public extension UserProfileCD {
    
    convenience init(_ profile: UserProfile, context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = profile.id
        name = profile.name
        avatarUrl = profile.avatarUrl
        aboutMyself = profile.aboutMyself
        topics = NSSet(array: profile.topics.map { TopicCD($0, context: context) })
    }
    
    func toDomain() -> UserProfile {
        UserProfile(
            id: id,
            name: name,
            avatarUrl: avatarUrl,
            aboutMyself: aboutMyself,
            topics: topics.toArray(of: TopicCD.self).map { $0.toDomain() },
            avatarData: avatarData
        )
    }
}
