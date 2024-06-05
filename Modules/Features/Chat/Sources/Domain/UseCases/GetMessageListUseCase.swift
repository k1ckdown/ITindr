//
//  GetMessageListUseCase.swift
//  Chat
//
//  Created by Ivan Semenov on 05.06.2024.
//

import ChatDomain
import CommonDomain

final class GetMessageListUseCase {

    private let chatRepository: ChatRepositoryProtocol

    init(chatRepository: ChatRepositoryProtocol) {
        self.chatRepository = chatRepository
    }

    func execute(chatId: String, pagination: Pagination) async throws -> [Message] {
        try await chatRepository.getChatMessages(chatId: chatId, pagination: pagination)
    }
}
