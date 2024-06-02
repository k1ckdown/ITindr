//
//  ChatViewCell.swift
//  ChatList
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UIKit
import CommonUI
import Kingfisher

final class ChatViewCell: UITableViewCell {

    var isSeparatorShowing = true {
        didSet {
            separatorView.isHidden = isSeparatorShowing == false
        }
    }

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let separatorView = UIView()
    private let avatarImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        messageLabel.text = nil
        avatarImageView.image = nil
        isSeparatorShowing = false
    }

    func configure(with viewModel: ChatCellViewModel) {
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.lastMessage

        let avatarPlaceholder = Images.avatarPlaceholder.image
        guard let avatarUrl = viewModel.avatarUrl else { return avatarImageView.image = avatarPlaceholder }
        avatarImageView.kf.setImage(with: URL(string: avatarUrl), placeholder: avatarPlaceholder)
    }
}

// MARK: - Setup

private extension ChatViewCell {

    func setup() {
        selectionStyle = .none
        setupContainerView()
        setupAvatarImageView()
        setupTitleLabel()
        setupMessageLabel()
        setupSeparatorView()
    }

    func setupContainerView() {
        contentView.addSubview(containerView)

        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.contentInsetHorizontal),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.contentInsetHorizontal),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setupAvatarImageView() {
        containerView.addSubview(avatarImageView)

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.avatarCornerRadius
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
        ])
    }

    func setupTitleLabel() {
        containerView.addSubview(titleLabel)

        titleLabel.font = Fonts.uiBold16
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.titleInsetLeading)
        ])
    }

    func setupMessageLabel() {
        containerView.addSubview(messageLabel)

        messageLabel.font = Fonts.uiRegular16
        messageLabel.textColor = .darkGray
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = Constants.messageNumberOfLines
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.messageInsetTop),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    func setupSeparatorView() {
        containerView.addSubview(separatorView)

        separatorView.backgroundColor = Colors.appLightGray.color
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight),
            separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.separatorInsetLeading),
            separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

// MARK: - Constants

private extension ChatViewCell {

    enum Constants {
        static let messageNumberOfLines = 2
        static let avatarSize: CGFloat = 64
        static let avatarCornerRadius: CGFloat = avatarSize / 2
        static let separatorHeight: CGFloat = 1
        static let messageInsetTop: CGFloat = 4
        static let titleInsetLeading: CGFloat = 16
        static let contentInsetHorizontal: CGFloat = 16
        static let separatorInsetLeading: CGFloat = avatarSize + titleInsetLeading
    }
}
