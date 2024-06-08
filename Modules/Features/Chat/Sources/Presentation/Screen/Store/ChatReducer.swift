//
//  ChatReducer.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import CommonUI
import ChatDomain
import CommonDomain

typealias ChatStore = StoreOf<ChatReducer>

struct ChatReducer: Reducer {

    func reduce(state: inout ChatState, intent: ChatIntent) {
        switch intent {
        case .sendMessageTapped, .loadMore: break
        case .onAppear:
            state = .loading
        case .loadFailed(let error):
            state = .failed(error)
        case .loadMoreStarted:
            handleLoadMoreStart(&state)
        case .dataLoaded(let data):
            handleDataLoad(&state, data: data)
        case .messageCreated(let message):
            handleMessageCreate(&state, message: message)
        case .messageChanged(let text):
            handleMessageChange(&state, text: text)
        case .addAttachmentTapped:
            handleAddAttachmentTap(&state)
        case .sourceTypeSelected(let type):
            handleSourceTypeSelect(&state, type)
        case .attachmentChosen(let attachment):
            handleAttachmentChoice(&state, attachment)
        }
    }
}

// MARK: - Private methods

private extension ChatReducer {

    func handleAddAttachmentTap(_ state: inout ChatState) {
        guard case .loaded(var viewData) = state else { return }
        viewData.isSourceTypeAlertPresented = true
        state = .loaded(viewData)
    }

    func handleAttachmentChoice(_ state: inout ChatState, _ attachment: Resource) {
        guard case .loaded(var viewData) = state else { return }

        viewData.chosenAttachment = attachment
        viewData.photoSourceType = nil
        state = .loaded(viewData)
    }

    func handleSourceTypeSelect(_ state: inout ChatState, _ type: PhotoSourceType?) {
        guard case .loaded(var viewData) = state else { return }

        viewData.photoSourceType = type
        viewData.isSourceTypeAlertPresented = false
        state = .loaded(viewData)
    }

    func handleMessageChange(_ state: inout ChatState, text: String) {
        guard case .loaded(var viewData) = state else { return }

        viewData.messageText = text
        state = .loaded(viewData)
    }

    func handleLoadMoreStart(_ state: inout ChatState) {
        guard case .loaded(var viewData) = state else { return }

        viewData.isMoreLoading = true
        state = .loaded(viewData)
    }

    func handleMessageCreate(_ state: inout ChatState, message: Message) {
        guard case .loaded(var viewData) = state else { return }

        viewData.messageText = ""
        viewData.chosenAttachment = nil
        viewData.isMessageCreated = true
        viewData.messages.insert(mapToViewModel(message: message), at: 0)

        state = .loaded(viewData)
    }

    func handleDataLoad(_ state: inout ChatState, data: ChatIntent.LoadData) {
        let messageCellViewModels = data.messages.map { mapToViewModel(message: $0) }
        let nextPage = data.pagination.nextPage

        switch state {
        case .loading:
            let viewData = ChatState.ViewData(
                chatTitle: data.chat.title,
                chatAvatarUrl: data.chat.avatarUrl,
                pagination: nextPage,
                messages: messageCellViewModels
            )
            state = .loaded(viewData)

        case .loaded(var viewData):
            viewData.pagination = nextPage
            viewData.messages.append(contentsOf: messageCellViewModels)
            viewData.isMoreLoading = false
            viewData.isMessageCreated = false
            state = .loaded(viewData)
        default: return
        }
    }

    func mapToViewModel(message: Message) -> MessageCellViewModel {
        MessageCellViewModel(
            text: message.text,
            avatar: message.user.avatar,
            createdAt: message.createdAt,
            isOutgoing: message.isOutgoing
        )
    }
}
