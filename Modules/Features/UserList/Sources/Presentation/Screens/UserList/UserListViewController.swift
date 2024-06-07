//
//  UserListViewController.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UIKit
import Combine
import CommonUI

final class UserListViewController: UIViewController, LoadableView {

    private let store: UserListStore
    private let dataSource: UserListDataSource
    private var subscriptions = Set<AnyCancellable>()

    private(set) var loadingView = UIActivityIndicatorView()
    private lazy var userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UserListLayout())

    init(store: UserListStore) {
        self.store = store
        dataSource = UserListDataSource(store: store)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bindToState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(.onAppear)
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

// MARK: - State Binding

private extension UserListViewController {

    func bindToState() {
        store.objectWillChange
            .throttle(for: 0, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.render() }
            .store(in: &subscriptions)
    }

    func render() {
        switch store.state {
        case .failed: isLoading(false)
        case .idle, .loading: isLoading(true)
        case .loaded(let viewData): handleViewData(viewData)
        }
    }

    func handleViewData(_ viewData: UserListState.ViewData) {
        isLoading(false)
        dataSource.loadingView?.isShowing = viewData.isMoreLoading
        updateUserList(viewModels: viewData.users)
    }

    func updateUserList(viewModels: [UserCellViewModel]) {
        let previousUserCount = userCollectionView.numberOfItems(inSection: 0)
        guard previousUserCount < viewModels.count else { return }

        let indexPaths = (previousUserCount..<viewModels.count).map { IndexPath(item: $0, section: 0) }
        userCollectionView.performBatchUpdates { userCollectionView.insertItems(at: indexPaths) }
    }
}

// MARK: - Constants

private extension UserListViewController {

    enum Constants {
        static let collectionContentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
