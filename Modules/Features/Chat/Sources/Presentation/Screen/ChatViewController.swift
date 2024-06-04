//
//  ChatViewController.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit
import CommonUI

final class ChatViewController: UIViewController {

    private let viewModel: ChatViewModel
    private let dataSource: ChatDataSource

    private lazy var messageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    init(with viewModel: ChatViewModel) {
        self.viewModel = viewModel
        dataSource = ChatDataSource(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

// MARK: - Setup

private extension ChatViewController {

    func setup() {
        view.backgroundColor = Colors.appBackground.color
        setupMessageCollectionView()
    }

    func setupMessageCollectionView() {
        view.addSubview(messageCollectionView)

        messageCollectionView.backgroundColor = .clear
        messageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dataSource.configure(messageCollectionView)

        NSLayoutConstraint.activate([
            messageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            messageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            messageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
