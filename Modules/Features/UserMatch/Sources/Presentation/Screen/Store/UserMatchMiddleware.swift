//
//  UserMatchMiddleware.swift
//  UserMatch
//
//  Created by Ivan Semenov on 08.06.2024.
//

import UDFKit
import Navigation
import ChatDomain

@MainActor
protocol UserMatchMiddlewareDelegate: Sendable, ErrorPresentable {
    func goToChat(_ chat: Chat)
}

final class UserMatchMiddleware: Middleware {

    private let userId: String
    private let createChatUseCase: CreateChatUseCase
    private var delegate: UserMatchMiddlewareDelegate

    init(userId: String, createChatUseCase: CreateChatUseCase, delegate: UserMatchMiddlewareDelegate) {
        self.userId = userId
        self.createChatUseCase = createChatUseCase
        self.delegate = delegate
    }

    func handle(state: UserMatchState, intent: UserMatchIntent) async -> UserMatchIntent? {
        await handleWriteMessageTap()
        return nil
    }

    private func handleWriteMessageTap() async {
        do {
            let chat = try await createChatUseCase.execute(userId: userId)
            await delegate.goToChat(chat)
        } catch {
            await delegate.showError(error.localizedDescription)
        }
    }
}
