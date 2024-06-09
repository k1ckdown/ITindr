//
//  ProfileState.swift
//  UserFeed
//
//  Created by Ivan Semenov on 09.06.2024.
//

import CommonUI

struct ProfileState: Equatable {
    let username: String
    let avatarUrl: String?
    let aboutMyself: String?
    let topics: [TopicView.Model]
}

enum ProfileIntent: Equatable {}
