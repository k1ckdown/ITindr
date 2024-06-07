//
//  CreateChatUseCase.swift
//  UserMatch
//
//  Created by Ivan Semenov on 08.06.2024.
//

import ChatDomain

final class CreateChatUseCase {

    private let chatRepository: ChatRepositoryProtocol

    init(chatRepository: ChatRepositoryProtocol) {
        self.chatRepository = chatRepository
    }

    func execute(userId: String) async throws -> Chat {
        try await chatRepository.createChat(userId: userId)
    }
}
