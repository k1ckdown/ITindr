//
//  ModuleDependencies.swift
//  UserMatch
//
//  Created by Ivan Semenov on 07.06.2024.
//

import ChatDomain

public struct ModuleDependencies {
    let chatRepository: ChatRepositoryProtocol

    public init(chatRepository: ChatRepositoryProtocol) {
        self.chatRepository = chatRepository
    }
}
