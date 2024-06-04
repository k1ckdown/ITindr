//
//  UserProfileDTO.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

struct UserProfileDTO: Decodable {
    let userId: String
    let name: String
    let avatarUrl: String?
    let aboutMyself: String?
    let topics: [TopicDTO]
}
