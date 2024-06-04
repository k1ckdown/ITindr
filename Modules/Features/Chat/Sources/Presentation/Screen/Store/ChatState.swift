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
    case loaded([MessageCellViewModel])
}

enum ChatIntent {
    case onAppear
    case loadFailed(String)
    case dataLoaded([Message])
}
