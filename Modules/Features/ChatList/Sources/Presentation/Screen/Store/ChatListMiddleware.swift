//
//  ChatListMiddleware.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UDFKit
import Navigation
import ChatDomain

@MainActor
protocol ChatListMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToChat(with id: String)
}

final class ChatListMiddleware: Middleware {

    private var chats: [ChatDetails] = []
    private let getChatListUseCase: GetChatListUseCase
    private var delegate: ChatListMiddlewareDelegate?

    init(getChatListUseCase: GetChatListUseCase, delegate: ChatListMiddlewareDelegate?) {
        self.getChatListUseCase = getChatListUseCase
        self.delegate = delegate
    }

    func handle(state: ChatListState, intent: ChatListIntent) async -> ChatListIntent? {
        switch intent {
        case .dataLoaded, .loadFailed: break
        case .onAppear:
            return await getAllChats()
        case .chatTapped(let index):
            await handleChatTap(at: index)
        }

        return nil
    }
}

// MARK: - Private methods

private extension ChatListMiddleware {

    func handleChatTap(at index: Int) async {
        let chatId = chats[index].chat.id
        await delegate?.goToChat(with: chatId)
    }

    func getAllChats() async -> ChatListIntent {
        do {
            chats = try await getChatListUseCase.execute()
            return .dataLoaded(chats)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loadFailed(error.localizedDescription)
        }
    }
}
