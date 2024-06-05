//
//  ChatReducer.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import ChatDomain

typealias ChatStore = StoreOf<ChatReducer>

struct ChatReducer: Reducer {

    func reduce(state: inout ChatState, intent: ChatIntent) {
        switch intent {
        case .sendMessageTapped, .loadMore: break
        case .onAppear: state = .loading
        case .loadMoreStarted:
            guard case .loaded(var viewData) = state else { return }
            viewData.isMoreLoading = true
            state = .loaded(viewData)

        case .loadFailed(let error): state = .failed(error)

        case .messageCreated(let message):
            guard case .loaded(var viewData) = state else { return }
            viewData.messageText = ""
            viewData.isMessageCreated = true
            viewData.messages.insert(mapToViewModel(message: message), at: 0)
            state = .loaded(viewData)

        case .dataLoaded(let messages, let pagination):
            let messageCellViewModels = messages.map { mapToViewModel(message: $0) }
            switch state {
            case .loading:
                let viewData = ChatState.ViewData(loadMore: .available(pagination.nextPage), messages: messageCellViewModels)
                state = .loaded(viewData)
            case .loaded(var viewData):
                viewData.messages.append(contentsOf: messageCellViewModels)
                viewData.loadMore = .available(pagination.nextPage)
                viewData.isMoreLoading = false
                viewData.isMessageCreated = false
                state = .loaded(viewData)
            default: return
            }

        case .messageChanged(let text):
            guard case .loaded(var viewData) = state else { return }
            viewData.messageText = text
            state = .loaded(viewData)
        }
    }

    private func mapToViewModel(message: Message) -> MessageCellViewModel {
        MessageCellViewModel(
            text: message.text,
            avatar: message.user.avatar,
            createdAt: message.createdAt,
            isAuthor: message.isOutgoing
        )
    }
}
