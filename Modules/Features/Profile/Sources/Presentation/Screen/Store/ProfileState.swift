//
//  ProfileState.swift
//  ProfileInterface
//
//  Created by Ivan Semenov on 09.06.2024.
//

import CommonUI
import ProfileDomain

enum ProfileState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        let username: String
        let avatarUrl: String?
        let aboutMyself: String?
        let topics: [TopicView.Model]
    }
}

enum ProfileIntent: Equatable {
    case onAppear
    case editTapped
    case dataLoadFailed(String)
    case dataLoaded(UserProfile)
}
