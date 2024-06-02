//
//  ChatListViewModel.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Foundation

final class ChatListViewModel {

    var refreshList: (() -> Void)?
    var isLoading: ((Bool) -> Void)?
    var goToChat: ((String) -> Void)?

    private(set) var chatCellViewModels: [ChatCellViewModel] = []
}

// MARK: - Public methods

extension ChatListViewModel {

    func chatTapped(at index: IndexPath) {
        goToChat?(String(index.row))
    }

    func deleteChat(at index: IndexPath) {
        chatCellViewModels.remove(at: index.row)
    }

    func viewWillAppear() {
        isLoading?(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading?(false)
            self.chatCellViewModels = ChatCellViewModel.mock
            self.refreshList?()
        }
    }
}
