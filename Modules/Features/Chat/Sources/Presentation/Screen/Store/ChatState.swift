//
//  ChatState.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import ChatDomain
import CommonDomain

enum ChatState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)
    
    struct ViewData: Equatable {
        var messageText = ""
        var isMoreLoading = false
        var isMessageCreated = false
        var pagination: Pagination
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
