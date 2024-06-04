//
//  ChatViewController.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit
import CommonUI
import Combine
import Navigation

final class ChatViewController: UIViewController, LoadableView, TabBarHidden {

    private let store: ChatStore
    private let dataSource: ChatDataSource
    private var subscriptions = Set<AnyCancellable>()

    private let messageToolbar = UIView()
    private let messageTextView = UITextView()
    private let sendMessageButton = UIButton()
    private let addAttachmentButton = UIButton(type: .system)
    private let sendMessageGradientLayer = CAGradientLayer()
    private(set) var loadingView = UIActivityIndicatorView()

    private var messageToolbarHeightConstraint: NSLayoutConstraint?
    private var messageTextViewHeightConstraint: NSLayoutConstraint?

    private lazy var messageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.messageSpacing
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    init(store: ChatStore) {
        self.store = store
        dataSource = ChatDataSource(store: store)
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        sendMessageGradientLayer.frame = sendMessageButton.bounds
    }
}

// MARK: - Actions

private extension ChatViewController {

    @objc
    func handleSendMessageButton() {
        store.dispatch(.sendMessageTapped)
    }
}

// MARK: - Setup

private extension ChatViewController {

    func setup() {
        view.backgroundColor = Colors.appBackground.color
        setupMessageToolbar()
        setupMessageTextView()
        setupAddAttachmentButton()
        setupSendMessageButton()
        setupMessageCollectionView()
        setupLoadingView()
    }

    func setupMessageToolbar() {
        view.addSubview(messageToolbar)

        messageToolbar.translatesAutoresizingMaskIntoConstraints = false
        messageToolbarHeightConstraint = messageToolbar.heightAnchor.constraint(equalToConstant: Constants.messageToolbarHeight)
        messageToolbarHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            messageToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupMessageTextView() {
        messageToolbar.addSubview(messageTextView)

        // TODO: Placeholder
        messageTextView.delegate = self
        messageTextView.textColor = .black
        messageTextView.font = Fonts.uiRegular16
        messageTextView.tintColor = Colors.accentColor.color
        messageTextView.backgroundColor = Colors.appLightGray.color
        messageTextView.contentInset = Constants.messageViewContentInset
        messageTextView.layer.cornerRadius = Constants.messageViewCornerRadius
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextViewHeightConstraint = messageTextView.heightAnchor.constraint(equalToConstant: Constants.buttonActionSize)
        messageTextViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(equalTo: messageToolbar.topAnchor, constant: 3),
            messageTextView.leadingAnchor.constraint(equalTo: messageToolbar.leadingAnchor, constant: Constants.buttonActionSize + Constants.messageViewInsetLeft * 2),
            messageTextView.trailingAnchor.constraint(equalTo: messageToolbar.trailingAnchor, constant: -(Constants.buttonActionSize + Constants.sendMessageInsetLeft * 2))
        ])
    }

    func setupAddAttachmentButton() {
        messageToolbar.addSubview(addAttachmentButton)

        addAttachmentButton.setImage(Images.cameraIcon.image.withRenderingMode(.alwaysOriginal), for: .normal)
        addAttachmentButton.layer.borderWidth = Constants.addAttachmentBorderWidth
        addAttachmentButton.layer.cornerRadius = Constants.addAttachmentCornerRadius
        addAttachmentButton.layer.borderColor = Colors.appLightGray.color.cgColor
        addAttachmentButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addAttachmentButton.leadingAnchor.constraint(equalTo: messageToolbar.leadingAnchor, constant: Constants.messageToolbarInsetHorizontal),
            addAttachmentButton.heightAnchor.constraint(equalToConstant: Constants.buttonActionSize),
            addAttachmentButton.widthAnchor.constraint(equalToConstant: Constants.buttonActionSize),
            addAttachmentButton.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor),
        ])
    }

    func setupSendMessageButton() {
        messageToolbar.addSubview(sendMessageButton)

        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = Images.sendIcon.image.withRenderingMode(.alwaysOriginal)
        config.contentInsets = Constants.sendMessageContentInset
        sendMessageButton.configuration = config

        sendMessageGradientLayer.startPoint = Constants.sendMessageGradientStartPoint
        sendMessageGradientLayer.endPoint = Constants.sendMessageGradientEndPoint
        sendMessageGradientLayer.colors = [Colors.accentColor.color.cgColor, Colors.appPurple.color.cgColor]
        sendMessageGradientLayer.cornerRadius = Constants.sendMessageCornerRadius
        sendMessageButton.layer.addSublayer(sendMessageGradientLayer)
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        sendMessageButton.addTarget(self, action: #selector(handleSendMessageButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            sendMessageButton.heightAnchor.constraint(equalToConstant: Constants.buttonActionSize),
            sendMessageButton.widthAnchor.constraint(equalToConstant: Constants.buttonActionSize),
            sendMessageButton.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor),
            sendMessageButton.trailingAnchor.constraint(equalTo: messageToolbar.trailingAnchor, constant: -Constants.messageToolbarInsetHorizontal)
        ])
    }

    func setupMessageCollectionView() {
        view.addSubview(messageCollectionView)

        messageCollectionView.backgroundColor = .clear
        messageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dataSource.configure(messageCollectionView)

        NSLayoutConstraint.activate([
            messageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: messageToolbar.topAnchor, constant: Constants.messageCollectionInsetBottom),
            messageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func adjustMessageTextHeight() {
        let width = messageTextView.bounds.width
        let oldHeight = messageTextView.bounds.height

        let newHeight = messageTextView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let height = max(Constants.buttonActionSize, min(newHeight, Constants.messageViewMaxHeight))

        messageTextViewHeightConstraint?.constant = height
        messageToolbarHeightConstraint?.constant += height - oldHeight
    }
}

// MARK: - UITextViewDelegate

extension ChatViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        store.dispatch(.messageChanged(textView.text))
    }
}

// MARK: - State Binding

private extension ChatViewController {

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

    func scrollToLastMessage(messageCount: Int) {
        guard case .loaded(let viewData) = store.state else { return }

        let lastIndexPath = IndexPath(item: messageCount - 1, section: 0)
        messageCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: false)
    }

    func handleViewData(_ viewData: ChatState.ViewData) {
        isLoading(false)

        messageTextView.text = viewData.messageText
        adjustMessageTextHeight()

        messageCollectionView.reloadData()
        scrollToLastMessage(messageCount: viewData.messages.count)
    }
}

// MARK: - Constants

private extension ChatViewController {

    enum Constants {
        static let buttonActionSize: CGFloat = 40
        static let messageSpacing: CGFloat = 24
        static let messageCollectionInsetBottom: CGFloat = -10

        static let messageToolbarHeight: CGFloat = 80
        static let messageToolbarInsetHorizontal: CGFloat = 16

        static let addAttachmentBorderWidth: CGFloat = 1
        static let addAttachmentCornerRadius: CGFloat = 8

        static let sendMessageInsetLeft: CGFloat = 16
        static let sendMessageGradientEndPoint = CGPoint(x: 1, y: 0.5)
        static let sendMessageGradientStartPoint = CGPoint(x: 0, y: 0.5)
        static let sendMessageCornerRadius: CGFloat = buttonActionSize / 2
        static let sendMessageContentInset = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 5)

        static let messageViewInsetLeft: CGFloat = 16
        static let messageViewMaxHeight: CGFloat = 200
        static let messageViewCornerRadius: CGFloat = 4
        static let messageViewContentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
