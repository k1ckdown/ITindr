//
//  ChatListDataSource.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UIKit
import UDFKit
import CommonUI

final class ChatListDataSource: NSObject {

    private let store: ChatListStore

    init(store: ChatListStore) {
        self.store = store
    }

    func configure(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(ChatViewCell.self, forCellReuseIdentifier: ChatViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension ChatListDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .loaded(let cellViewModels) = store.state else { return 0 }
        return cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            case .loaded(let cellViewModels) = store.state,
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatViewCell.reuseIdentifier,
                for: indexPath
            ) as? ChatViewCell
        else { return .init() }

        cell.configure(with: cellViewModels[indexPath.row])
        cell.isSeparatorShowing = indexPath.row != cellViewModels.count - 1

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatListDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.dispatch(.chatTapped(indexPath.row))
    }
}
