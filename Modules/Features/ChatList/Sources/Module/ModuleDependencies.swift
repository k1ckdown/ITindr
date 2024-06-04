//
//  ModuleDependencies.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain
import ChatInterface

public struct ModuleDependencies {
    let chatRepository: ChatRepositoryProtocol
    let chatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol

    public init(chatRepository: ChatRepositoryProtocol, chatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol) {
        self.chatRepository = chatRepository
        self.chatCoordinatorAssembly = chatCoordinatorAssembly
    }
}
