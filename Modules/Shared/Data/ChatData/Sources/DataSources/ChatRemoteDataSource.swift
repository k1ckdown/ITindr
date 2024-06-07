//
//  ChatRemoteDataSource.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Network
import ChatDomain
import CommonDomain

final class ChatRemoteDataSource {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Public methods

extension ChatRemoteDataSource {

    func sendMessage(_ message: MessageSend) async throws -> MessageDTO {
        let networkConfig = ChatMultipartNetworkConfig.sendMessage(message)
        return try await networkService.multipartRequest(config: networkConfig, authorized: true)
    }

    func fetchAllChats() async throws -> [ChatDetailsDTO] {
        let networkConfig = ChatNetworkConfig.chatList
        return try await networkService.request(config: networkConfig, authorized: true)
    }

    func createChat(_ requestDto: CreateChatDTO) async throws -> ChatDTO {
        let networkConfig = ChatNetworkConfig.newChat(requestDto)
        return try await networkService.request(config: networkConfig, authorized: true)
    }

    func fetchChatMessages(chatId: String, pagination: Pagination) async throws -> [MessageDTO] {
        let networkConfig = ChatNetworkConfig.chatMessages(chatId: chatId, pagination: pagination)
        return try await networkService.request(config: networkConfig, authorized: true)
    }
}
