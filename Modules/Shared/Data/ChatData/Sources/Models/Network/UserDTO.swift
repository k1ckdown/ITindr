//
//  UserDTO.swift
//  ChatData
//
//  Created by Ivan Semenov on 02.06.2024.
//

struct UserDTO: Decodable {
    let id: String
    let name: String
    let avatar: String?
    let aboutMyself: String?
}
