//
//  UserViewCell.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UIKit
import CommonUI
import Kingfisher

final class UserViewCell: UICollectionViewCell {

    private let nameLabel = UILabel()
    private let avatarImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        avatarImageView.image = nil
    }

    func configure(with viewModel: UserCellViewModel) {
        nameLabel.text = viewModel.name

        let avatarPlaceholder = Images.avatarPlaceholder.image
        if let avatarUrl = viewModel.avatarUrl {
            avatarImageView.kf.setImage(with: URL(string: avatarUrl), placeholder: avatarPlaceholder)
        } else {
            avatarImageView.image = avatarPlaceholder
        }
    }
}

// MARK: - Setup

private extension UserViewCell {

    func setup() {
        setupAvatarImageView()
        setupNameLabel()
    }

    func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = Constants.avatarCornerRadius
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
        ])
    }

    func setupNameLabel() {
        contentView.addSubview(nameLabel)

        nameLabel.textColor = .black
        nameLabel.font = Fonts.uiBold16
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.nameInsetTop),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Constants

private extension UserViewCell {

    enum Constants {
        static let nameInsetTop: CGFloat = 16
        static let avatarSize: CGFloat = 104
        static let avatarCornerRadius: CGFloat = avatarSize / 2
    }
}
