//
//  UserProfileEdit+Mapping.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import ProfileDomain

extension UserProfile {
    
    func toDto() -> UserProfileDTO {
        UserProfileDTO(
            id: id,
            name: name,
            avatarUrl: avatarUrl,
            aboutMyself: aboutMyself,
            topics: topics.toDto()
        )
    }
}
