//
//  ChatRemoteDataSource.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Network
import ChatDomain

final class ChatRemoteDataSource {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Public methods

extension ChatRemoteDataSource {

    func fetchAllChats() async throws -> [ChatDetailsDTO] {
        let config = ChatNetworkConfig.chatList
        return try await networkService.request(config: config, authorized: true)
    }

    func createChat(userId: String) async throws -> ChatDTO {
        let config = ChatNetworkConfig.newChat(userId: userId)
        return try await networkService.request(config: config, authorized: true)
    }

    func fetchChatMessages(chatId: String, pagination: Pagination) async throws -> [MessageDTO] {
        let config = ChatNetworkConfig.chatMessages(chatId: chatId, pagination: pagination)
        return try await networkService.request(config: config, authorized: true)
    }
}
