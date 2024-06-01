//
//  TopicDTO+Mapping.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import TopicDomain

extension [TopicDTO] {

    func toDomain() -> [Topic] {
        map { $0.toDomain() }
    }
}

extension TopicDTO {

    func toDomain() -> Topic {
        Topic(id: id, title: title)
    }
}
