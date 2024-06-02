//
//  ChatListState.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import ChatDomain

enum ChatListState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded([ChatCellViewModel])
}

enum ChatListIntent: Equatable {
    case onAppear
    case chatTapped(Int)
    case loadFailed(String)
    case dataLoaded([ChatDetails])
}
