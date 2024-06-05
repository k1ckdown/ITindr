//
//  ChatState.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import ChatDomain
import CommonDomain

enum ChatState {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)

    struct ViewData {
        enum LoadMore: Equatable {
            case unavailable
            case failed(Pagination)
            case available(Pagination)
        }

        var messageText = ""
        var loadMore: LoadMore
        var isMoreLoading = false
        var isMessageCreated = false
        var messages: [MessageCellViewModel]
    }
}

enum ChatIntent {
    case onAppear
    case loadMore
    case loadMoreStarted
    case sendMessageTapped
    case loadFailed(String)
    case messageChanged(String)
    case messageCreated(Message)
    case dataLoaded([Message], Pagination)
}
