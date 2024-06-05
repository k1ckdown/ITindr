//
//  ChatMiddleware.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import Navigation
import ChatDomain
import CommonDomain

@MainActor
protocol ChatMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {}

final class ChatMiddleware: Middleware {

    private let chatId: String
    private let sendMessageUseCase: SendMessageUseCase
    private let getMessageListUseCase: GetMessageListUseCase
    private weak var delegate: ChatMiddlewareDelegate?

    init(
        chatId: String,
        sendMessageUseCase: SendMessageUseCase,
        getMessageListUseCase: GetMessageListUseCase,
        delegate: ChatMiddlewareDelegate?
    ) {
        self.chatId = chatId
        self.sendMessageUseCase = sendMessageUseCase
        self.getMessageListUseCase = getMessageListUseCase
        self.delegate = delegate
    }

    func handle(state: ChatState, intent: ChatIntent) async -> ChatIntent? {
        switch intent {
        case .dataLoaded, .loadFailed, .messageChanged, .messageCreated: break
        case .onAppear:
            return await getMessages(pagination: .firstPage)
        case .sendMessageTapped:
            return await handleSendMessageTap(state: state)
        case .loadMore:
            return checkLoadMoreAvailable(state: state) ? .loadMoreStarted : nil
        case .loadMoreStarted:
            return await loadMore(state: state)
        }

        return nil
    }
}

// MARK: - Private methods

private extension ChatMiddleware {

    func loadMore(state: ChatState) async -> ChatIntent? {
        guard case .loaded(let viewData) = state, case .available(let pagination) = viewData.loadMore else { return nil }
        return await getMessages(pagination: pagination)
    }

    func getMessages(pagination: Pagination) async -> ChatIntent {
        do {
            let messages = try await getMessageListUseCase.execute(chatId: chatId, pagination: pagination)
            return .dataLoaded(messages, pagination)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loadFailed(error.localizedDescription)
        }
    }

    func checkLoadMoreAvailable(state: ChatState) -> Bool {
        guard
            case .loaded(let viewData) = state,
            case .available(let pagination) = viewData.loadMore,
            viewData.isMoreLoading == false,
            viewData.messages.count >= pagination.offset
        else { return false }
        return true
    }

    func handleSendMessageTap(state: ChatState) async -> ChatIntent? {
        guard case .loaded(let viewData) = state, viewData.messageText.isEmpty == false else { return nil }

        do {
            let messageSend = MessageSend(chatId: chatId, text: viewData.messageText, attachments: [])
            let message = try await sendMessageUseCase.execute(messageSend)
            return .messageCreated(message)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return nil
        }
    }
}
