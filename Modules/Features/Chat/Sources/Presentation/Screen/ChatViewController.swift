//
//  ChatViewController.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit
import CommonUI

final class ChatViewController: UIViewController {

    private let store: ChatStore
    private let dataSource: ChatDataSource

    private let messageToolbar = UIView()
    private let messageTextView = UITextView()
    private let sendMessageButton = UIButton()
    private let addAttachmentButton = UIButton(type: .system)
    private let sendMessageGradientLayer = CAGradientLayer()

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(.onAppear)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard case .loaded(let cellViewModels) = store.state else { return }
        
        sendMessageGradientLayer.frame = sendMessageButton.bounds
        let lastIndexPath = IndexPath(item: cellViewModels.count - 1, section: 0)
        messageCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: false)
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
        messageTextView.text = "Message..."
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
            messageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            messageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: messageToolbar.topAnchor, constant: Constants.messageCollectionInsetBottom),
            messageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITextViewDelegate

extension ChatViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let width = messageTextView.bounds.width
        let oldHeight = messageTextView.bounds.height

        let newHeight = textView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let height = max(Constants.buttonActionSize, min(newHeight, Constants.messageViewMaxHeight))

        messageTextViewHeightConstraint?.constant = height
        messageToolbarHeightConstraint?.constant += height - oldHeight
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
