//
//  ChatRepository.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Foundation
import ChatDomain

final class ChatRepository {

    private let remoteDataSource: ChatRemoteDataSource

    init(remoteDataSource: ChatRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - ChatRepositoryProtocol

extension ChatRepository: ChatRepositoryProtocol {

    func sendMessage(_ message: MessageSend) async throws -> Message {
        throw NSError()
    }

    func createChat(userId: String) async throws -> Chat {
        let chatDto = try await remoteDataSource.createChat(userId: userId)
        return chatDto.toDomain()
    }

    func getAllChats() async throws -> [ChatDetails] {
        let chatDtos = try await remoteDataSource.fetchAllChats()
        return chatDtos.toDomain()
    }

    func getChatMessages(chatId: String, pagination: Pagination) async throws -> [Message] {
        let messageDtos = try await remoteDataSource.fetchChatMessages(chatId: chatId, pagination: pagination)
        return messageDtos.toDomain()
    }
}
