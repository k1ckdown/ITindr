//
//  FeedScreen.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import SwiftUI
import CommonUI
import Kingfisher
import Navigation

struct FeedScreen: View, NavigationBarHidden {

    @StateObject private var store: StoreOf<FeedReducer>

    init(store: StoreOf<FeedReducer>) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        content
            .onAppear {
                store.dispatch(.onAppear)
            }
    }

    @ViewBuilder
    private var content: some View {
        switch store.state {
        case .idle, .failed:
            ZStack { EmptyView() }
        case .loading:
            ProgressView().tintColor()
        case .loaded(let user):
            loadedView(user)
        }
    }
}

// MARK: - Views

private extension FeedScreen {

    @ViewBuilder
    func loadedView(_ user: FeedState.User?) -> some View {
        Group {
            if let user { userView(user) } else { placeholderView() }
        }
        .appLogo(padding: Constants.appLogoInsetTop)
    }

    func actionButtonLabel(title: String, image: Image) -> some View {
        HStack(spacing: .zero) {
            image.renderingMode(.template)
            Text(title).padding(.leading, Constants.actionTitleInsetLeading)
        }
    }

    func placeholderView() -> some View {
        Text("No users").frame(maxHeight: .infinity)
    }

    func avatarView(url: String?) -> some View {
        Group {
            if let avatarUrl = url {
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

    func actionButtons() -> some View {
        HStack(spacing: Constants.actionButtonSpacing) {
            Button {
                store.dispatch(.rejectTapped)
            } label: {
                actionButtonLabel(title: UserFeedStrings.reject, image: Images.xCircleIcon.swiftUIImage)
            }
            .mainButtonStyle(isProminent: false)

            Button {
                store.dispatch(.likeTapped)
            } label: {
                actionButtonLabel(title: UserFeedStrings.like, image: Images.heartIcon.swiftUIImage)
            }
            .mainButtonStyle()
        }
    }

    func userView(_ user: FeedState.User) -> some View {
        VStack(spacing: .zero) {
            VStack(spacing: Constants.contentSpacing) {
                avatarView(url: user.avatarUrl)
                    .onTapGesture {
                        store.dispatch(.avatarTapped)
                    }

                VStack {
                    Text(user.username)
                        .font(Fonts.bold24)

                    // TODO: Tags
                }

                Text(user.aboutMyself ?? "")
                    .font(Fonts.regular16)
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity, alignment: .top)

            actionButtons().padding(.bottom)
        }
        .padding(.horizontal)
    }
}

// MARK: - Constants

private extension FeedScreen {

    enum Constants {
        static let avatarSize: CGFloat = 206
        static let contentSpacing: CGFloat = 32
        static let appLogoInsetTop: CGFloat = 32
        static let actionButtonSpacing: CGFloat = 20
        static let actionTitleInsetLeading: CGFloat = 16
    }
}
