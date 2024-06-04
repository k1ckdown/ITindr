//
//  SendMessageUseCase.swift
//  Chat
//
//  Created by Ivan Semenov on 05.06.2024.
//

import ChatDomain

final class SendMessageUseCase {
    
    private let chatRepository: ChatRepositoryProtocol
    
    init(chatRepository: ChatRepositoryProtocol) {
        self.chatRepository = chatRepository
    }
    
    func execute(_ message: MessageSend) async throws -> Message {
        try await chatRepository.sendMessage(message)
    }
}
