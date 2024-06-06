//
//  UserListDataSource.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UIKit
import CommonUI

final class UserListDataSource: NSObject {

    private let store: UserListStore
    private(set) var loadingView: LoadingReusableView?

    init(store: UserListStore) {
        self.store = store
    }

    func configure(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UserViewCell.self, forCellWithReuseIdentifier: UserViewCell.reuseIdentifier)
        collectionView.register(
            LoadingReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: LoadingReusableView.reuseIdentifier
        )
    }
}

// MARK: - UICollectionViewDataSource

extension UserListDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard case .loaded(let viewData) = store.state else { return 0 }
        return viewData.users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            case .loaded(let viewData) = store.state,
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserViewCell.reuseIdentifier,
                for: indexPath
            ) as? UserViewCell
        else { return .init() }

        cell.configure(with: viewData.users[indexPath.item])
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

// MARK: - UICollectionViewDelegate

extension UserListDataSource: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.dispatch(.userTapped(indexPath.item))
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case .loaded(let viewData) = store.state, indexPath.item == viewData.users.count - 1 else { return }
        store.dispatch(.loadMore)
    }
}
