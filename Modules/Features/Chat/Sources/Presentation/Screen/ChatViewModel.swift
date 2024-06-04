//
//  ChatViewModel.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

final class ChatViewModel {

    private let chatId: String

    private(set) var cellViewModels: [MessageCellViewModel] = []

    init(chatId: String) {
        self.chatId = chatId
    }
}

// MARK: - Public methods

extension ChatViewModel {

    func viewWillAppear() {
        cellViewModels = MessageCellViewModel.mock
    }
}
