//
//  ChatRepository.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Foundation
import ChatDomain

final class ChatRepository {

    private let userIdProvider: UserIdProvider
    private let remoteDataSource: ChatRemoteDataSource

    init(userIdProvider: @escaping UserIdProvider, remoteDataSource: ChatRemoteDataSource) {
        self.userIdProvider = userIdProvider
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - ChatRepositoryProtocol

extension ChatRepository: ChatRepositoryProtocol {

    func sendMessage(_ messageSend: MessageSend) async throws -> Message {
        let messageDto = try await remoteDataSource.sendMessage(messageSend)
        return messageDto.toDomain(isOutgoing: true)
    }

    func createChat(userId: String) async throws -> Chat {
        let chatDto = try await remoteDataSource.createChat(userId: userId)
        return chatDto.toDomain()
    }

    func getAllChats() async throws -> [ChatDetails] {
        let chatDtos = try await remoteDataSource.fetchAllChats()
        let userId = try await userIdProvider()

        return chatDtos.map { $0.toDomain(lastMessageIsOutgoing: userId == $0.lastMessage?.user.userId) }
    }

    func getChatMessages(chatId: String, pagination: Pagination) async throws -> [Message] {
        let messageDtos = try await remoteDataSource.fetchChatMessages(chatId: chatId, pagination: pagination)
        let userId = try await userIdProvider()

        return messageDtos.map { $0.toDomain(isOutgoing: userId == $0.user.userId) }
    }
}
