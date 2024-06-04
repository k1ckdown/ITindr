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
        case .sendMessageTapped: break
        case .onAppear: state = .loading

        case .loadFailed(let error): state = .failed(error)

        case .messageCreated(let message):
            guard case .loaded(var viewData) = state else { return }
            viewData.messageText = ""
            viewData.messages.append(mapToViewModel(message: message))
            state = .loaded(viewData)
            
        case .dataLoaded(let messages):
            let messageCellViewModels = messages.map { mapToViewModel(message: $0) }
            state = .loaded(.init(messages: messageCellViewModels.reversed()))

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
