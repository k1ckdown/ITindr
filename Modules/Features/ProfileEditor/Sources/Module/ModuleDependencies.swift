//
//  ModuleDependencies.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import Navigation
import TopicDomain
import ProfileDomain

public struct ModuleDependencies {
    let topicRepository: TopicRepositoryProtocol
    let profileRepository: ProfileRepositoryProtocol

    public init(topicRepository: TopicRepositoryProtocol, profileRepository: ProfileRepositoryProtocol) {
        self.topicRepository = topicRepository
        self.profileRepository = profileRepository
    }
}
