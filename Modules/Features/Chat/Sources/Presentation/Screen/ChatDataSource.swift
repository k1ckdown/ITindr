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
    private(set) var loadingView: LoadingReusableView?

    init(store: ChatStore) {
        self.store = store
    }

    func configure(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(MessageViewCell.self, forCellWithReuseIdentifier: MessageViewCell.reuseIdentifier)
        collectionView.register(
            LoadingReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoadingReusableView.reuseIdentifier
        )
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let loadingView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: LoadingReusableView.reuseIdentifier,
                for: indexPath
            ) as? LoadingReusableView
        else { return .init() }

        self.loadingView = loadingView
        return loadingView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case .loaded(let viewData) = store.state, indexPath.item == viewData.messages.count - 1 else { return }
        store.dispatch(.loadMore)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard case .loaded(let viewData) = store.state else { return .zero }
        
        let cellViewModel = viewData.messages[indexPath.item]
        messageDummyCell.configure(with: cellViewModel)
        let cellSize = messageDummyCell.sizeThatFits(CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))

        return cellSize
    }
}
