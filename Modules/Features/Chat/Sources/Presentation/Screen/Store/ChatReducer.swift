//
//  ChatReducer.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
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
        }
    }
}

// MARK: - Private methods

private extension ChatReducer {

    func handleMessageChange(_ state: inout State, text: String) {
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
