//
//  UserListViewController.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UIKit
import CommonUI

final class UserListViewController: UIViewController, LoadableView {

    private let viewModel: UserListViewModel
    private let dataSource: UserListDataSource

    private(set) var loadingView = UIActivityIndicatorView()
    private lazy var userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UserListLayout())

    init(with viewModel: UserListViewModel) {
        self.viewModel = viewModel
        dataSource = UserListDataSource(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bindToViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

// MARK: - Setup

private extension UserListViewController {

    func setup() {
        view.backgroundColor = Colors.appBackground.color
        setupUserCollectionView()
        setupLoadingView()
    }

    func setupUserCollectionView() {
        view.addSubview(userCollectionView)

        userCollectionView.contentInset = Constants.collectionContentInset
        userCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dataSource.configure(userCollectionView)

        NSLayoutConstraint.activate([
            userCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            userCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ViewModel Binding

private extension UserListViewController {

    func bindToViewModel() {
        viewModel.isLoading = isLoading

        viewModel.refreshUserList = { [weak self] in
            self?.userCollectionView.reloadData()
        }
    }
}

// MARK: - Constants

private extension UserListViewController {

    enum Constants {
        static let collectionContentInset = UIEdgeInsets(top: 0, left: 16, bottom: 50, right: 16)
    }
}
