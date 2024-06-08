//
//  ChatMiddleware.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import Foundation
import Navigation
import ChatDomain
import CommonDomain
import ChatInterface

@MainActor
protocol ChatMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {}

final class ChatMiddleware: Middleware {

    var refreshMessagesHandler: (([Message]) -> Void)?

    private let chat: Chat
    private var refreshTimer: Timer?
    private let sendMessageUseCase: SendMessageUseCase
    private let getMessageListUseCase: GetMessageListUseCase
    private weak var delegate: ChatMiddlewareDelegate?

    init(
        chat: Chat,
        sendMessageUseCase: SendMessageUseCase,
        getMessageListUseCase: GetMessageListUseCase,
        delegate: ChatMiddlewareDelegate?
    ) {
        self.chat = chat
        self.sendMessageUseCase = sendMessageUseCase
        self.getMessageListUseCase = getMessageListUseCase
        self.delegate = delegate
    }

    func handle(state: ChatState, intent: ChatIntent) async -> ChatIntent? {
        switch intent {
        case .onAppear:
            await setupRefreshTimer()
            return await getMessages(pagination: .firstPage)
        case .sendMessageTapped:
            return await handleSendMessageTap(state: state)
        case .loadMore:
            return checkLoadMoreAvailable(state: state) ? .loadMoreStarted : nil
        case .loadMoreStarted:
            return await loadMore(state: state)
        case .dataLoaded, .loadFailed, .messageChanged, .messageCreated,
                .addAttachmentTapped, .sourceTypeSelected, .attachmentChosen, .messagesRefreshed: break
        }

        return nil
    }
}

// MARK: - Private methods

private extension ChatMiddleware {

    func loadMore(state: ChatState) async -> ChatIntent? {
        guard case .loaded(let viewData) = state else { return nil }
        return await getMessages(pagination: viewData.pagination)
    }

    func checkLoadMoreAvailable(state: ChatState) -> Bool {
        guard
            case .loaded(let viewData) = state,
            viewData.isMoreLoading == false,
            viewData.messages.count >= viewData.pagination.offset
        else { return false }
        return true
    }

    @MainActor
    func setupRefreshTimer() {
        guard refreshTimer == nil else { return }

        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.refreshMessages()
        }
    }

    func refreshMessages() {
        Task {
            let pagination = Pagination(offset: 0)
            let messages = try? await getMessageListUseCase.execute(chatId: chat.id, pagination: pagination)
            if let messages { refreshMessagesHandler?(messages) }
        }
    }

    func getMessages(pagination: Pagination) async -> ChatIntent {
        do {
            let messages = try await getMessageListUseCase.execute(chatId: chat.id, pagination: pagination)
            let loadData = ChatIntent.LoadData(chat: chat, messages: messages, pagination: pagination)
            return .dataLoaded(loadData)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loadFailed(error.localizedDescription)
        }
    }

    func handleSendMessageTap(state: ChatState) async -> ChatIntent? {
        guard
            case .loaded(let viewData) = state,
            (viewData.messageText.isEmpty && viewData.chosenAttachment == nil) == false
        else { return nil }

        let attachments = if let chosenAttachment = viewData.chosenAttachment { [chosenAttachment.data] } else { [Data]() }
        do {
            let messageSend = MessageSend(chatId: chat.id, text: viewData.messageText, attachments: attachments)
            let message = try await sendMessageUseCase.execute(messageSend)
            return .messageCreated(message)
        } catch {
            await delegate?.showError(error.localizedDescription)
            return nil
        }
    }
}
