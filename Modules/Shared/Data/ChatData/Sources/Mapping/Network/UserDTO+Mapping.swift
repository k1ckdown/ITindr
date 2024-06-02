//
//  UserDTO+Mapping.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

extension UserDTO {

    func toDomain() -> User {
        User(
            id: id,
            name: name,
            avatar: avatar,
            aboutMyself: aboutMyself
        )
    }
}
