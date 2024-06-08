//
//  ChatState.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import CommonUI
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
        var messageCreatedCount = 0
        var pagination: Pagination
        var chosenAttachment: Resource?
        var messages: [MessageCellViewModel]
        var photoSourceType: PhotoSourceType?
        var isSourceTypeAlertPresented = false
    }
}

enum ChatIntent: Equatable {
    case onAppear
    case loadMore
    case loadMoreStarted
    case sendMessageTapped
    case addAttachmentTapped
    case loadFailed(String)
    case dataLoaded(LoadData)
    case messageChanged(String)
    case messageCreated(Message)
    case attachmentChosen(Resource)
    case messagesRefreshed([Message])
    case sourceTypeSelected(PhotoSourceType?)

    struct LoadData: Equatable {
        let chat: Chat
        let messages: [Message]
        let pagination: Pagination
    }
}
