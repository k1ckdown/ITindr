//
//  ChatViewController.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit
import Combine
import CommonUI
import Navigation
import Kingfisher
import CommonDomain

final class ChatViewController: UIViewController, LoadableView, TabBarHidden, Keyboardable {

    private let store: ChatStore
    private let dataSource: ChatDataSource
    private var subscriptions = Set<AnyCancellable>()

    private let titleView = ChatTitleView()
    private let messageToolbar = UIView()
    private let messageTextView = UITextView()
    private let sendMessageButton = UIButton()
    private let addAttachmentButton = UIButton(type: .system)
    private let sendMessageGradientLayer = CAGradientLayer()
    private(set) var loadingView = UIActivityIndicatorView()

    private var attachmentView = UIView()
    private var attachmentImageView = UIImageView()
    private let sourceTypeAlert = UIAlertController(title: "Select the source type", message: nil, preferredStyle: .alert)

    private var messageToolbarHeightConstraint: NSLayoutConstraint?
    private var messageTextViewHeightConstraint: NSLayoutConstraint?
    private var messageToolbarBottomConstraint: NSLayoutConstraint?

    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()

    private lazy var messageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.messageSpacing
        layout.footerReferenceSize = Constants.footerSize
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
        setupObservers()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        messageTextView.setupPlaceholderLayout()
        sendMessageGradientLayer.frame = sendMessageButton.bounds
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UITextViewDelegate

extension ChatViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        store.dispatch(.messageChanged(textView.text))
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard 
            let image = info[.originalImage] as? UIImage,
            let imageData = image.jpegData(compressionQuality: 0.5)
        else { return }

        attachmentImageView.image = image
        let resource = Resource(data: imageData, fileName: "")

        store.dispatch(.attachmentChosen(resource))
    }
}

// MARK: - Actions

private extension ChatViewController {

    @objc
    func handleSendMessageButton() {
        store.dispatch(.sendMessageTapped)
    }

    @objc
    func handleAddAttachmentButton() {
        store.dispatch(.addAttachmentTapped)
    }

    @objc
    func handleMessageCollectionTap() {
        view.endEditing(true)
    }
}

// MARK: - Setup

private extension ChatViewController {

    func setup() {
        setupSuperView()
        setupMessageToolbar()
        setupMessageTextView()
        setupAddAttachmentButton()
        setupSendMessageButton()
        setupMessageCollectionView()
        setupLoadingView()
        setupAttachmentView()
        setupAttachmentImageView()
        setupSourceTypeAlert()
        view.bringSubviewToFront(messageToolbar)
    }

    func setupSuperView() {
        navigationItem.titleView = titleView
        view.backgroundColor = Colors.appBackground.color
    }

    func setupMessageToolbar() {
        view.addSubview(messageToolbar)

        messageToolbar.translatesAutoresizingMaskIntoConstraints = false
        messageToolbarHeightConstraint = messageToolbar.heightAnchor.constraint(equalToConstant: Constants.messageToolbarHeight)
        messageToolbarHeightConstraint?.isActive = true
        messageToolbarBottomConstraint = messageToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        messageToolbarBottomConstraint?.isActive = true

        NSLayoutConstraint.activate([
            messageToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupMessageTextView() {
        messageToolbar.addSubview(messageTextView)

        messageTextView.delegate = self
        messageTextView.textColor = .black
        messageTextView.font = Fonts.uiRegular16
        // TODO: Localize
        messageTextView.placeholder = "Message..."
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
        addAttachmentButton.addTarget(self, action: #selector(handleAddAttachmentButton), for: .touchUpInside)

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
        messageCollectionView.keyboardDismissMode = .onDrag
        messageCollectionView.transform = CGAffineTransform(scaleX: 1, y: -1)
        messageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dataSource.configure(messageCollectionView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMessageCollectionTap))
        messageCollectionView.addGestureRecognizer(tapGesture)

        NSLayoutConstraint.activate([
            messageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: messageToolbar.topAnchor, constant: Constants.messageCollectionInsetBottom),
            messageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupAttachmentView() {
        view.addSubview(attachmentView)

        attachmentView.isHidden = true
        attachmentView.backgroundColor = .black.withAlphaComponent(0.2)
        attachmentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            attachmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            attachmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            attachmentView.topAnchor.constraint(equalTo: view.topAnchor),
            attachmentView.bottomAnchor.constraint(equalTo: messageCollectionView.bottomAnchor)
        ])
    }

    func setupAttachmentImageView() {
        attachmentView.addSubview(attachmentImageView)

        attachmentImageView.contentMode = .scaleToFill
        attachmentImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            attachmentImageView.leadingAnchor.constraint(equalTo: attachmentView.leadingAnchor),
            attachmentImageView.trailingAnchor.constraint(equalTo: attachmentView.trailingAnchor),
            attachmentImageView.heightAnchor.constraint(equalToConstant: 200),
            attachmentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setupSourceTypeAlert() {
        // TODO: Localize
        let actions = [
            UIAlertAction(title: "Photos", style: .default, handler: { [weak self] _ in
                self?.store.dispatch(.sourceTypeSelected(.library))
            }),
            UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                self?.store.dispatch(.sourceTypeSelected(.camera))
            }),
            UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
                self?.store.dispatch(.sourceTypeSelected(nil))
            })
        ]

        actions.forEach { sourceTypeAlert.addAction($0) }
    }

    func adjustMessageTextHeight() {
        let width = messageTextView.bounds.width
        let oldHeight = messageTextView.bounds.height

        let newHeight = messageTextView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude)).height
        let height = max(Constants.buttonActionSize, min(newHeight, Constants.messageViewMaxHeight))

        messageTextViewHeightConstraint?.constant = height
        messageToolbarHeightConstraint?.constant += height - oldHeight
    }

    func setupObservers() {
        registerKeyboardWillHideNotification { [weak self] in
            self?.messageToolbarBottomConstraint?.constant = 0
            self?.view.layoutIfNeeded()
        }

        registerKeyboardWillShowNotification { [weak self] keyboardFrame in
            self?.messageToolbarBottomConstraint?.constant = -keyboardFrame.height + Constants.keyboardInsetTop
            self?.view.layoutIfNeeded()
        }
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

    func handleViewData(_ viewData: ChatState.ViewData) {
        isLoading(false)
        updateMessages(viewData)
        updateImagePicker(viewData)
        updateMessageText(viewData.messageText)
        dataSource.loadingView?.isShowing = viewData.isMoreLoading
        updateTitleView(title: viewData.chatTitle, avatarUrl: viewData.chatAvatarUrl)
    }

    func updateImagePicker(_ viewData: ChatState.ViewData) {
        viewData.isSourceTypeAlertPresented ? present(sourceTypeAlert, animated: true) : sourceTypeAlert.dismiss(animated: true)

        if let photoSourceType = viewData.photoSourceType {
            imagePicker.sourceType = photoSourceType == .camera ? .camera : .photoLibrary
            present(imagePicker, animated: true)
        } else {
            imagePicker.dismiss(animated: true)
        }

        attachmentView.isHidden = viewData.chosenAttachment == nil
    }

    func scrollToLastMessage(messageCount: Int) {
        let lastIndexPath = IndexPath(item: messageCount - 1, section: 0)
        messageCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: false)
    }

    func updateMessageText(_ text: String) {
        messageTextView.text = text
        adjustMessageTextHeight()
    }

    func updateMessages(_ viewData: ChatState.ViewData) {
        let previousMessageCount = messageCollectionView.numberOfItems(inSection: 0)
        guard viewData.messages.count != previousMessageCount else { return }

        let indexPaths = viewData.messageCreatedCount != 0
        ? (0..<viewData.messageCreatedCount).map { IndexPath(item: $0, section: 0) }
        : (previousMessageCount..<viewData.messages.count).map { IndexPath(item: $0, section: 0) }

        messageCollectionView.performBatchUpdates { messageCollectionView.insertItems(at: indexPaths) }
    }

    func updateTitleView(title: String, avatarUrl: String?) {
        guard titleView.title == nil else { return }

        titleView.title = title
        let avatarPlaceholder = Images.avatarPlaceholder.image
        if let avatarUrl {
            titleView.avatarImageView.kf.setImage(with: URL(string: avatarUrl), placeholder: avatarPlaceholder)
        } else {
            titleView.avatarImageView.image = avatarPlaceholder
        }
    }
}

// MARK: - Constants

private extension ChatViewController {

    enum Constants {
        static let buttonActionSize: CGFloat = 40
        static let messageSpacing: CGFloat = 24
        static let messageCollectionInsetBottom: CGFloat = -10
        static let footerSize = CGSize(width: 150, height: 65)

        static let messageToolbarHeight: CGFloat = 80
        static let messageToolbarInsetHorizontal: CGFloat = 16

        static let addAttachmentBorderWidth: CGFloat = 1
        static let addAttachmentCornerRadius: CGFloat = 8

        static let sendMessageInsetLeft: CGFloat = 16
        static let sendMessageGradientEndPoint = CGPoint(x: 1, y: 0.5)
        static let sendMessageGradientStartPoint = CGPoint(x: 0, y: 0.5)
        static let sendMessageCornerRadius: CGFloat = buttonActionSize / 2
        static let sendMessageContentInset = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 5)

        static let keyboardInsetTop: CGFloat = 22
        static let messageViewInsetLeft: CGFloat = 16
        static let messageViewMaxHeight: CGFloat = 200
        static let messageViewCornerRadius: CGFloat = 4
        static let messageViewContentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
