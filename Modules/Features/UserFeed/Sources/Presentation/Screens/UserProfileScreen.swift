//
//  UserProfileScreen.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI
import CommonUI

struct UserProfileScreen: View {

    var body: some View {
        VStack {
            VStack(spacing: Constants.contentSpacing) {
                Images.avatarPlaceholder.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                    .clipShape(.circle)

                VStack {
                    Text("Ivan Ivanov")
                        .font(Fonts.bold24)

                    // TODO: Tags
                }

                Text("I love painting buttons")
                    .font(Fonts.regular16)
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity, alignment: .top)

            HStack(spacing: Constants.actionButtonSpacing) {
                Button {

                } label: {
                    actionButtonLabel(title: UserFeedStrings.reject, image: Images.xCircleIcon.swiftUIImage)
                }
                .mainButtonStyle(isProminent: false)

                Button {

                } label: {
                    actionButtonLabel(title: UserFeedStrings.like, image: Images.heartIcon.swiftUIImage)
                }
                .mainButtonStyle()
            }
            .padding(.bottom)
        }
        .padding(.horizontal)
        .appLogo()
    }
}

// MARK: - Views

private extension UserProfileScreen {

    func actionButtonLabel(title: String, image: Image) -> some View {
        HStack(spacing: .zero) {
            image.renderingMode(.template)
            Text(title).padding(.leading, Constants.actionTitleInsetLeading)
        }
    }
}

// MARK: - Constants

private extension UserProfileScreen {

    enum Constants {
        static let avatarSize: CGFloat = 206
        static let contentSpacing: CGFloat = 32
        static let actionButtonSpacing: CGFloat = 20
        static let actionTitleInsetLeading: CGFloat = 16
    }
}

#Preview {
    UserProfileScreen()
}
