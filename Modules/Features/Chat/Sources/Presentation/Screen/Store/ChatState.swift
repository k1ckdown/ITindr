//
//  ChatState.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import ChatDomain

enum ChatState {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)

    struct ViewData {
        var messageText = ""
        var messages: [MessageCellViewModel]
    }
}

enum ChatIntent {
    case onAppear
    case sendMessageTapped
    case loadFailed(String)
    case dataLoaded([Message])
    case messageChanged(String)
    case messageCreated(Message)
}
