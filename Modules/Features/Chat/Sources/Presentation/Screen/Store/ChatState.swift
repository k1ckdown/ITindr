//
//  ChatState.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import ChatDomain
import CommonDomain
import ChatInterface

enum ChatState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        var messageText = ""
        var chatTitle: String
        var chatAvatarUrl: String?
        var isMoreLoading = false
        var isMessageCreated = false
        var pagination: Pagination
        var messages: [MessageCellViewModel]
    }
}

enum ChatIntent: Equatable {
    case onAppear
    case loadMore
    case loadMoreStarted
    case sendMessageTapped
    case loadFailed(String)
    case dataLoaded(LoadData)
    case messageChanged(String)
    case messageCreated(Message)

    struct LoadData: Equatable {
        let chat: Chat
        let messages: [Message]
        let pagination: Pagination
    }
}
