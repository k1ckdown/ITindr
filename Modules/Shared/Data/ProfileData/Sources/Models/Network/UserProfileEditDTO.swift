//
//  UserProfileEditDTO.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

struct UserProfileEditDTO: Encodable {
    let name: String
    let aboutMyself: String?
    let topics: [TopicDTO]
}
