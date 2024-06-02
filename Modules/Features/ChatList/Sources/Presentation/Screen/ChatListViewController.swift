//
//  ChatListViewController.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UIKit
import SwiftUI
import CommonUI
import Combine

final class ChatListViewController: UIViewController, LoadableView {

    @StateObject private var store: ChatListStore
    private let dataSource: ChatListDataSource
    private var subscriptions = Set<AnyCancellable>()

    private let chatTableView = UITableView()
    private(set) var loadingView = UIActivityIndicatorView()

    init(store: ChatListStore) {
        _store = StateObject(wrappedValue: store)
        dataSource = ChatListDataSource(store: store)
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
        store.dispatch(.onAppear)
    }
}

// MARK: - Setup

private extension ChatListViewController {

    func setup() {
        navigationItem.title = "Chats"
        view.backgroundColor = Colors.appBackground.color
        setupChatTableView()
        setupLoadingView()
    }

    func setupChatTableView() {
        view.addSubview(chatTableView)

        chatTableView.separatorStyle = .none
        chatTableView.rowHeight = Constants.chatRowHeight
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        dataSource.configure(chatTableView)

        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ViewModel Binding

private extension ChatListViewController {

    func bindToViewModel() {
        store.objectWillChange
            .throttle(for: 0, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] _ in
                self?.render()
            }
            .store(in: &subscriptions)
    }

    func render() {
        switch store.state {
        case .failed: 
            break
        case .idle, .loading:
            isLoading(true)
        case .loaded:
            chatTableView.reloadData()
        }
    }
}

// MARK: - Constants

private extension ChatListViewController {

    enum Constants {
        static let chatRowHeight: CGFloat = 96
    }
}
