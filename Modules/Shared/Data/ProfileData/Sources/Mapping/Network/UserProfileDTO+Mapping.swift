//
//  UserProfileDTO+Mapping.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import ProfileDomain

extension UserProfileDTO {
    
    func toDomain() -> UserProfile {
        UserProfile(
            id: userId,
            name: name,
            avatarUrl: avatarUrl,
            aboutMyself: aboutMyself,
            topics: topics.toDomain()
        )
    }
}
