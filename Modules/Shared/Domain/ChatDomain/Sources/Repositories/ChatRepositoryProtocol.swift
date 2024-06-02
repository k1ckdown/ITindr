//
//  ChatRepositoryProtocol.swift
//  ChatDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public protocol ChatRepositoryProtocol: AnyObject {
    func createChat(userId: String) async throws
    func getAllChats() async throws -> [ChatDetails]
    func sendMessage(_ message: MessageSend) async throws -> Message
    func getChatMessages(chatId: String, pagination: Pagination) async throws -> [Message]
}
