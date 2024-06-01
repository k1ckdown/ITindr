//
//  UserProfileDTO.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

struct UserProfileDTO: Decodable {
    let id: String
    let name: String
    let avatarUrl: String?
    let aboutMyself: String?
    let topics: [TopicDTO]
}
