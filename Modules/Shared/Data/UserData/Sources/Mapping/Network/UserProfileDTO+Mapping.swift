//
//  UserProfileDTO+Mapping.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

extension [UserProfileDTO] {

    func toDomain() -> [UserProfile] {
        map { $0.toDomain() }
    }
}

extension UserProfileDTO {
    
    func toDomain() -> UserProfile {
        UserProfile(
            id: id,
            name: name,
            avatarUrl: avatarUrl,
            aboutMyself: aboutMyself,
            topics: topics.toDomain()
        )
    }
}
