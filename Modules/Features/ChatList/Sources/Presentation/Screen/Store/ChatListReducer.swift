//
//  ChatListReducer.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UDFKit
import ChatDomain

typealias ChatListStore = StoreOf<ChatListReducer>

struct ChatListReducer: Reducer {

    func reduce(state: inout ChatListState, intent: ChatListIntent) {
        switch intent {
        case .chatTapped: break
        case .onAppear:
            state = .loading
        case .loadFailed(let message):
            state = .failed(message)
        case .dataLoaded(let chats):
            let cellViewModels = chats.map { mapToViewModel(chatDetails: $0) }
            state = .loaded(cellViewModels)
        }
    }

    private func mapToViewModel(chatDetails: ChatDetails) -> ChatCellViewModel {
        ChatCellViewModel(
            id: chatDetails.chat.id,
            title: chatDetails.chat.title,
            avatarUrl: chatDetails.chat.avatar,
            lastMessage: chatDetails.lastMessage?.text
        )
    }
}
