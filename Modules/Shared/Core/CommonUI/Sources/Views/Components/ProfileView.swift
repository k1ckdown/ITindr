//
//  ProfileView.swift
//  CommonUI
//
//  Created by Ivan Semenov on 07.06.2024.
//

import SwiftUI
import Kingfisher

public struct ProfileView: View {

    let model: Model

    public init(model: Model) {
        self.model = model
    }

    public var body: some View {
        VStack(spacing: Constants.contentSpacing) {
            avatarView()
                .onTapGesture {
                    model.avatarTapped?()
                }

            VStack {
                Text(model.username)
                    .font(Fonts.bold24)

                // TODO: Topics
            }

            Text(model.aboutMyself ?? "")
                .font(Fonts.regular16)
                .multilineTextAlignment(.center)
        }
    }

    private func avatarView() -> some View {
        Group {
            if let avatarUrl = model.avatarUrl {
                KFImage(URL(string: avatarUrl))
                    .placeholder { Images.avatarPlaceholder.swiftUIImage }
                    .resizable()
            } else {
                Images.avatarPlaceholder.swiftUIImage.resizable()
            }
        }
        .scaledToFill()
        .frame(width: Constants.avatarSize, height: Constants.avatarSize)
        .clipShape(.circle)
    }
}

// MARK: - Model

public extension ProfileView {

    struct Model {
        let username: String
        let avatarUrl: String?
        let aboutMyself: String?
        let topics: [String]
        let avatarTapped: (() -> Void)?

        public init(username: String, avatarUrl: String?, aboutMyself: String?, topics: [String], avatarTapped: (() -> Void)? = nil) {
            self.username = username
            self.avatarUrl = avatarUrl
            self.aboutMyself = aboutMyself
            self.topics = topics
            self.avatarTapped = avatarTapped
        }
    }
}

// MARK: - Constants

private extension ProfileView {

    enum Constants {
        static let avatarSize: CGFloat = 206
        static let contentSpacing: CGFloat = 32
    }
}
