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
    private weak var delegate: ChatMiddlewareDelegate?

    init(chatId: String, delegate: ChatMiddlewareDelegate?) {
        self.chatId = chatId
        self.delegate = delegate
    }

    func handle(state: ChatState, intent: ChatIntent) async -> ChatIntent? {
        switch intent {
        case .dataLoaded, .loadFailed: break
        case .onAppear:
            return getMessages()
        }

        return nil
    }
}

// MARK: - Private methods

private extension ChatMiddleware {

    func getMessages() -> ChatIntent {
        print(chatId)
        return .dataLoaded(MessageCellViewModel.mock)
    }
}
