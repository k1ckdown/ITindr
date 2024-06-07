//
//  TabFlow.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import CommonUI

enum TabFlow: Int, CaseIterable {
    case userFeed
    case userList
    case chatList
    case profile

    var tag: Int {
        rawValue
    }

    // TODO: Localize
    var title: String {
        switch self {
        case .userFeed: "Feed"
        case .userList: "Users"
        case .chatList: "Chats"
        case .profile: "Profile"
        }
    }

    var image: UIImage {
        switch self {
        case .userFeed: Images.feedIcon.image
        case .userList: Images.peopleIcon.image
        case .chatList: Images.chatIcon.image
        case .profile: Images.profileIcon.image
        }
    }
}
