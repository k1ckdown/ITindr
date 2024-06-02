//
//  UserProfileDTO.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

struct UserProfileDTO: Decodable {
    let userId: String
    let name: String
    let avatar: String?
    let aboutMyself: String?
    let topics: [TopicDTO]
}
