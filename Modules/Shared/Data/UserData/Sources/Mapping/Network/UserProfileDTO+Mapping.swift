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
            id: userId,
            name: name,
            avatarUrl: avatar,
            aboutMyself: aboutMyself,
            topics: topics.toDomain()
        )
    }
}
