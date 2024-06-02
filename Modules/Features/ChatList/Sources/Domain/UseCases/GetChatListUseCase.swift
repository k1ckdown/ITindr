//
//  GetChatListUseCase.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

final class GetChatListUseCase {

    private let chatRepository: ChatRepositoryProtocol

    init(chatRepository: ChatRepositoryProtocol) {
        self.chatRepository = chatRepository
    }

    func execute() async throws -> [ChatDetails] {
        try await chatRepository.getAllChats()
    }
}
