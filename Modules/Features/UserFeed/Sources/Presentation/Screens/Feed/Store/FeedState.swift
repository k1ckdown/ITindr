//
//  FeedState.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import CommonUI
import ProfileDomain

enum FeedState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(User?)

    struct User: Equatable {
        let username: String
        let avatarUrl: String?
        let aboutMyself: String?
        let topics: [TopicView.Model]
        var isMutual = false
    }
}

enum FeedIntent: Equatable {
    case onAppear
    case usersMatched
    case likeTapped
    case rejectTapped
    case avatarTapped
    case loadFailed(String)
    case userSelected(UserProfile?)
}
