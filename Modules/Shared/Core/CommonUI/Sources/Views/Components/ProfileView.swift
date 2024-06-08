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

                TagLayout(model.topics) {
                    TopicView(model: $0)
                }
            }

            Text(model.aboutMyself ?? "")
                .font(Fonts.regular16)
                .multilineTextAlignment(.center)
                .padding(.top, model.topics.count == 0 ? 0 : Constants.contentSpacing)
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
        let topics: [TopicView.Model]
        let avatarTapped: (() -> Void)?

        public init(username: String, avatarUrl: String?, aboutMyself: String?, topics: [TopicView.Model], avatarTapped: (() -> Void)? = nil) {
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
