//
//  UserListDataSource.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UIKit

final class UserListDataSource: NSObject {

    private let viewModel: UserListViewModel

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    func configure(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UserViewCell.self, forCellWithReuseIdentifier: UserViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension UserListDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.userCellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserViewCell.reuseIdentifier,
                for: indexPath
            ) as? UserViewCell
        else { return .init() }

        cell.configure(with: viewModel.userCellViewModels[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension UserListDataSource: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userTapped(at: indexPath.item)
    }
}
