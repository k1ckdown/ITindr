//
//  ChatMiddleware.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import Navigation

@MainActor
protocol ChatMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {}

final class ChatMiddleware: Middleware {
    
    private let chatId: String
    private let getMessageListUseCase: GetMessageListUseCase
    private weak var delegate: ChatMiddlewareDelegate?
    
    init(chatId: String, getMessageListUseCase: GetMessageListUseCase, delegate: ChatMiddlewareDelegate?) {
        self.chatId = chatId
        self.getMessageListUseCase = getMessageListUseCase
        self.delegate = delegate
    }
    
    func handle(state: ChatState, intent: ChatIntent) async -> ChatIntent? {
        switch intent {
        case .dataLoaded, .loadFailed: break
        case .onAppear:
            return await getMessages()
        }
        
        return nil
    }
}

// MARK: - Private methods

private extension ChatMiddleware {
    
    func getMessages() async -> ChatIntent {
        do {
            let messages = try await getMessageListUseCase.execute(chatId: chatId, pagination: .init(page: 0, count: 10))
            return .dataLoaded(messages)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loadFailed(error.localizedDescription)
        }
    }
}
