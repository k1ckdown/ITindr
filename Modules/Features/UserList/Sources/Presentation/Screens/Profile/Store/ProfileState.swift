//
//  ProfileState.swift
//  UserList
//
//  Created by Ivan Semenov on 07.06.2024.
//

import CommonUI
import ProfileDomain

enum ProfileState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(User)

    struct User: Equatable {
        let username: String
        let avatarUrl: String?
        let aboutMyself: String?
        let topics: [TopicView.Model]
    }
}

enum ProfileIntent: Equatable {
    case onAppear
    case likeTapped
    case rejectTapped
    case dataLoaded(UserProfile)
}
