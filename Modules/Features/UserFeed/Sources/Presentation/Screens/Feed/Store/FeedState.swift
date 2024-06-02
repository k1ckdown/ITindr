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
        var isMutual = false
    }
}

enum FeedIntent: Equatable {
    case onAppear
    case usersMatched
    case usersMatchDisappear
    case likeTapped
    case rejectTapped
    case avatarTapped
    case writeMessageTapped
    case loadFailed(String)
    case userSelected(UserProfile?)
}
