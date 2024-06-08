//
//  UserProfileEdit+Mapping.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import ProfileDomain

extension UserProfileEdit {

    func toDto() -> UserProfileEditDTO {
        UserProfileEditDTO(
            name: name,
            aboutMyself: aboutMyself,
            topics: topics
        )
    }
}
