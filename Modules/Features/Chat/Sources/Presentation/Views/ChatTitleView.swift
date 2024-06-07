//
//  ChatTitleView.swift
//  ChatInterface
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UIKit
import CommonUI

final class ChatTitleView: UIView {

    var title: String? {
        didSet {
            titleLabel.text = title
            setupLayout()
        }
    }

    private let titleLabel = UILabel()
    private(set) var avatarImageView = UIImageView()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension ChatTitleView {

    func setup() {
        setupAvatarImageView()
        setupTitleLabel()
    }

    func setupAvatarImageView() {
        addSubview(avatarImageView)
        avatarImageView.image = Images.avatarPlaceholder.image
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.avatarCornerRadius
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = Fonts.uiSemibold16
        titleLabel.textAlignment = .left
        titleLabel.textColor = Colors.accentColor.color
    }

    func setupLayout() {
        avatarImageView.frame.size = CGSize(width: Constants.avatarSize, height: Constants.avatarSize)
        avatarImageView.frame.origin.y = (bounds.height - Constants.avatarSize) / 2

        let titleSize = titleLabel.sizeThatFits(CGSize(width: bounds.width, height: .greatestFiniteMagnitude))
        let titleWidth = min(titleSize.width, Constants.maxTitleWidth)
        let titleHeight = titleSize.height

        let contentWidth = titleWidth + Constants.avatarSize + Constants.titleInsetLeft
        avatarImageView.frame.origin.x = contentWidth / -2

        titleLabel.frame.size.width = titleWidth
        titleLabel.frame.size.height = titleHeight
        titleLabel.frame.origin.y = (bounds.height - titleHeight) / 2
        titleLabel.frame.origin.x = avatarImageView.frame.maxX + Constants.titleInsetLeft
    }
}

// MARK: - Constants

private extension ChatTitleView {

    enum Constants {
        static let avatarSize: CGFloat = 32
        static let titleInsetLeft: CGFloat = 8
        static let maxTitleWidth: CGFloat = 100
        static let avatarCornerRadius = avatarSize / 2
    }
}
