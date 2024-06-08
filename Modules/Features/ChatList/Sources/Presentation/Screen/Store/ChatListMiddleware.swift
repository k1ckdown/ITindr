//
//  ChatListMiddleware.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UDFKit
import Navigation
import ChatDomain
import Foundation

@MainActor
protocol ChatListMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToChat(with chat: Chat)
}

final class ChatListMiddleware: Middleware {

    var refreshChatsHandler: (([ChatDetails]) -> Void)?
    private var refreshTimer: Timer?
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
            await setupRefreshTimer()
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
        let chat = chats[index].chat
        await delegate?.goToChat(with: chat)
    }

    func refreshChats() {
        Task {
            let chats = try? await getChatListUseCase.execute()
            if let chats { refreshChatsHandler?(chats) }
        }
    }

    @MainActor
    func setupRefreshTimer() {
        guard refreshTimer == nil else { return }

        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.refreshChats()
        }
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
