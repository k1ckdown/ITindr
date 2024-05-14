//
//  TopicDTO+Mapping.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import TopicDomain

extension [Topic] {

    func toDto() -> [TopicDTO] {
        map { $0.toDto() }
    }
}

extension Topic {

    func toDto() -> TopicDTO {
        TopicDTO(id: id, title: title)
    }
}
