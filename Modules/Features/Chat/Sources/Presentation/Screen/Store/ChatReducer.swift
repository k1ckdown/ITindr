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
        case .onAppear:
            state = .loading
        case .loadFailed(let message):
            state = .failed(message)
        case .dataLoaded(let messages):
//            let messageCellViewModels = messages.map { mapToViewModel(message: $0) }
            state = .loaded(messages)
        }
    }

    private func mapToViewModel(message: Message) -> MessageCellViewModel {
        MessageCellViewModel(
            text: message.text,
            avatar: message.user.avatar,
            createdAt: message.createdAt,
            isAuthor: false
        )
    }
}
