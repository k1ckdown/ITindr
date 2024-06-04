//
//  ModuleDependencies.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import ChatDomain

public struct ModuleDependencies {
    let chatRepository: ChatRepositoryProtocol

    public init(chatRepository: ChatRepositoryProtocol) {
        self.chatRepository = chatRepository
    }
}
