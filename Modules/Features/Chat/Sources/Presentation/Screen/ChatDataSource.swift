//
//  ChatDataSource.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit

final class ChatDataSource: NSObject {

    private let store: ChatStore
    private let messageDummyCell = MessageViewCell()

    init(store: ChatStore) {
        self.store = store
    }

    func configure(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(MessageViewCell.self, forCellWithReuseIdentifier: MessageViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ChatDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard case .loaded(let viewData) = store.state else { return 0 }
        return viewData.messages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            case .loaded(let viewData) = store.state,
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MessageViewCell.reuseIdentifier,
                for: indexPath
            ) as? MessageViewCell
        else { return .init() }

        let cellViewModel = viewData.messages[indexPath.item]
        cell.configure(with: cellViewModel)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard case .loaded(let viewData) = store.state else { return .zero }

        let cellViewModel = viewData.messages[indexPath.item]
        messageDummyCell.configure(with: cellViewModel)
        let cellSize = messageDummyCell.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))

        return cellSize
    }
}
