//
//  FeedState.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

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
        let topics: [String]
    }
}

enum FeedIntent: Equatable {
    case onAppear
    case likeTapped
    case rejectTapped
    case avatarTapped
    case loadFailed(String)
    case userLoaded(UserProfile?)
}
