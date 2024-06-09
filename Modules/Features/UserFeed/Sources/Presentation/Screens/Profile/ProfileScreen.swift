//
//  ProfileScreen.swift
//  UserFeed
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UDFKit
import SwiftUI
import CommonUI
import Kingfisher
import Navigation

struct ProfileScreen: View, TabBarHidden {

    @StateObject private var store: StoreOf<ProfileReducer>

    init(store: StoreOf<ProfileReducer>) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(store.state.username)
                .font(Fonts.bold24)
                .foregroundStyle(Colors.appWhite.swiftUIColor)

            Text(store.state.aboutMyself ?? "")
                .font(Fonts.regular16)
                .lineLimit(Constants.aboutMyselfLineLimit)
                .foregroundStyle(Colors.appWhite.swiftUIColor)
                .padding(.top, Constants.aboutMyselfInsetTop)

            TagLayout(store.state.topics) {
                TopicView(model: $0)
            }
            .padding(.top, Constants.topicsInsetTop)
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.contentInsetBottom)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .background {
            Group {
                if let avatarUrl = store.state.avatarUrl {
                    KFImage(URL(string: avatarUrl))
                        .placeholder { Images.avatarPlaceholder.swiftUIImage }
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.secondary
                }
            }
            .ignoresSafeArea()
        }
    }
}

// MARK: - Constants

private extension ProfileScreen {

    enum Constants {
        static let aboutMyselfLineLimit = 2
        static let topicsInsetTop: CGFloat = 16
        static let contentInsetBottom: CGFloat = 35
        static let aboutMyselfInsetTop: CGFloat = 8
    }
}
