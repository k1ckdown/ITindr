//
//  MessageViewCell.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UIKit
import CommonUI
import Kingfisher

final class MessageViewCell: UICollectionViewCell {

    private var isOutgoing = false
    private let textLabel = UILabel()
    private let sentDateLabel = UILabel()
    private let messageContentView = UIView()
    private let avatarImageView = UIImageView()
    private let attachmentImageView = UIImageView()
    private var attachmentImageSize = Constants.attachmentImageSize

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        textLabel.text = nil
        sentDateLabel.text = nil
        avatarImageView.image = nil
        attachmentImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayoutAndGetHeight(for: bounds.width)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let height = setupLayoutAndGetHeight(for: size.width)
        return CGSize(width: size.width, height: height)
    }

    func configure(with viewModel: MessageCellViewModel) {
        isOutgoing = viewModel.isOutgoing
        textLabel.text = viewModel.text
        setMessageContentStyle(isOutgoing: viewModel.isOutgoing)
        setSentDate(viewModel.createdAt)
        setAttachmentImage(with: viewModel.imageUrl)
        setAvatarImage(with: viewModel.avatar)
        setNeedsLayout()
    }
}

// MARK: - Private methods

private extension MessageViewCell {

    func setSentDate(_ dateTime: Date) {
        let time = dateTime.formatted(.dateTime.hour().minute())
        let date = dateTime.formatted(.dateTime.day().month(.wide).year())
        sentDateLabel.text = "\(time) • \(date)".lowercased()
    }

    func setMessageContentStyle(isOutgoing: Bool) {
        messageContentView.backgroundColor = isOutgoing ? Colors.appLightGray.color : .clear
        messageContentView.layer.borderColor = (isOutgoing ? .clear : Colors.appGray.color).cgColor
        messageContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        messageContentView.layer.maskedCorners.insert(isOutgoing ? .layerMinXMaxYCorner : .layerMaxXMaxYCorner)
    }

    func setAttachmentImage(with url: String?) {
        if let imageUrl = url {
            attachmentImageSize = Constants.attachmentImageSize
            attachmentImageView.kf.setImage(with: URL(string: imageUrl))
        } else {
            attachmentImageSize = .zero
        }
    }

    func setAvatarImage(with url: String?) {
        let avatarPlaceholder = Images.avatarPlaceholder.image
        if let avatarUrl = url {
            avatarImageView.kf.setImage(with: URL(string: avatarUrl), placeholder: avatarPlaceholder)
        } else {
            avatarImageView.image = avatarPlaceholder
        }
    }
}

// MARK: - Setup

private extension MessageViewCell {

    func setup() {
        setupAvatarImageView()
        setupMessageContentView()
        setupAttachmentImageView()
        setupTextLabel()
        setupSentDateLabel()
        contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
    }

    func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.avatarCornerRadius
    }

    func setupMessageContentView() {
        contentView.addSubview(messageContentView)
        messageContentView.backgroundColor = .lightGray
        messageContentView.layer.borderWidth = Constants.messageContentBorderWidth
        messageContentView.layer.cornerRadius = Constants.messageContentCornerRadius
    }

    func setupAttachmentImageView() {
        messageContentView.addSubview(attachmentImageView)
        attachmentImageView.contentMode = .scaleAspectFill
        attachmentImageView.layer.masksToBounds = true
        attachmentImageView.layer.cornerRadius = Constants.attachmentImageCornerRadius
    }

    func setupTextLabel() {
        messageContentView.addSubview(textLabel)
        textLabel.numberOfLines = Constants.textNumberOfLines
        textLabel.textColor = .black
        textLabel.font = Fonts.uiRegular16
    }

    func setupSentDateLabel() {
        messageContentView.addSubview(sentDateLabel)
        sentDateLabel.font = Fonts.uiRegular12
        sentDateLabel.textColor = Colors.appDarkGray.color
    }

    @discardableResult
    func setupLayoutAndGetHeight(for width: CGFloat) -> CGFloat {
        let maxContentWidth = width - Constants.messageContentInsetEnd

        let textSize = textLabel.sizeThatFits(CGSize(width: maxContentWidth, height: .greatestFiniteMagnitude))
        let sentDateSize = sentDateLabel.sizeThatFits(CGSize(width: maxContentWidth, height: .greatestFiniteMagnitude))

        let textHeight = textSize.height
        let messageWidth = max(textSize.width, sentDateSize.width, attachmentImageSize.width)

        let messageContentWidth = messageWidth + Constants.messageContentPadding * 2

        attachmentImageView.frame = CGRect(
            origin: CGPoint(x: Constants.messageContentPadding, y: Constants.messageContentPadding),
            size: attachmentImageSize
        )

        textLabel.frame = CGRect(
            x: Constants.messageContentPadding,
            y: attachmentImageView.frame.maxY + (attachmentImageSize == .zero ? 0 : Constants.textInsetTop),
            width: messageWidth,
            height: textHeight
        )

        sentDateLabel.frame = CGRect(
            x: textLabel.frame.origin.x,
            y: textLabel.frame.maxY + Constants.sentDateInsetTop,
            width: sentDateSize.width,
            height: sentDateSize.height
        )

        messageContentView.frame = CGRect(
            x: isOutgoing ? width - messageContentWidth - Constants.messageContentInsetStart : Constants.messageContentInsetStart,
            y: 0,
            width: messageContentWidth,
            height: sentDateLabel.frame.maxY + Constants.messageContentPadding
        )

        avatarImageView.frame = CGRect(
            x: isOutgoing ? width - Constants.avatarSize - Constants.contentInsetHorizontal : Constants.contentInsetHorizontal,
            y: messageContentView.frame.maxY - Constants.avatarSize,
            width: Constants.avatarSize,
            height: Constants.avatarSize
        )

        return messageContentView.frame.maxY
    }
}

// MARK: - Constants

private extension MessageViewCell {

    enum Constants {
        static let avatarSize: CGFloat = 32
        static let avatarCornerRadius = avatarSize / 2

        static let messageContentPadding: CGFloat = 16
        static let messageContentInsetEnd: CGFloat = 200
        static let messageContentBorderWidth: CGFloat = 1
        static let messageContentCornerRadius: CGFloat = 10
        static let messageContentInsetStart: CGFloat = avatarSize + 10 + contentInsetHorizontal

        static let textNumberOfLines = 0
        static let textInsetTop: CGFloat = 8
        static let sentDateInsetTop: CGFloat = 6
        static let contentInsetHorizontal: CGFloat = 16
        static let attachmentImageCornerRadius: CGFloat = 4
        static let attachmentImageSize = CGSize(width: 176, height: 128)
    }
}
