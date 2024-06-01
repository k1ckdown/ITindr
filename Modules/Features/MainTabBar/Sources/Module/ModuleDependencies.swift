//
//  ModuleDependencies.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileInterface
import ChatListInterface
import UserFeedInterface
import UserListInterface

public struct ModuleDependencies {
    let profileCoordinatorAssembly: ProfileCoordinatorAssemblyProtocol
    let chatListCoordinatorAssembly: ChatListCoordinatorAssemblyProtocol
    let userFeedCoordinatorAssembly: UserFeedCoordinatorAssemblyProtocol
    let userListCoordinatorAssembly: UserListCoordinatorAssemblyProtocol

    public init(
        profileCoordinatorAssembly: ProfileCoordinatorAssemblyProtocol,
        chatListCoordinatorAssembly: ChatListCoordinatorAssemblyProtocol,
        userFeedCoordinatorAssembly: UserFeedCoordinatorAssemblyProtocol,
        userListCoordinatorAssembly: UserListCoordinatorAssemblyProtocol
    ) {
        self.profileCoordinatorAssembly = profileCoordinatorAssembly
        self.chatListCoordinatorAssembly = chatListCoordinatorAssembly
        self.userFeedCoordinatorAssembly = userFeedCoordinatorAssembly
        self.userListCoordinatorAssembly = userListCoordinatorAssembly
    }
}
