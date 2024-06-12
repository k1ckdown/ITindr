//
//  TabFlow.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import CommonUI

typealias Strings = MainTabBarStrings

enum TabFlow: Int, CaseIterable {
    case userFeed
    case userList
    case chatList
    case profile

    var tag: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .userFeed: Strings.feed
        case .userList: Strings.users
        case .chatList: Strings.chats
        case .profile: Strings.profile
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
