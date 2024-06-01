//
//  ChatListCoordinatorAssembly.swift
//  ChatList
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation
import ChatListInterface

public struct ChatListCoordinatorAssembly: ChatListCoordinatorAssemblyProtocol {
    
    public init() {}
    
    public func assemble(navigationController: NavigationController) -> ChatListCoordinatorProtocol {
        ChatListCoordinator(navigationController: navigationController)
    }
}
