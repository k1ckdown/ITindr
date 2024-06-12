//
//  FeedScreen.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import SwiftUI
import CommonUI
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
        if let user { profileView(user) } else { placeholderView() }
    }

    func placeholderView() -> some View {
        VStack(spacing: .zero) {
            Images.startPreview.swiftUIImage
                .resizable()
                .scaledToFit()
                .frame(height: Constants.placeholderImageHeight)

            Text(UserFeedStrings.noUsers)
                .font(Fonts.bold24)
                .padding(.top, Constants.noUsersInsetTop)
        }
    }

    func profileView(_ user: FeedState.User) -> some View {
        FullScrollView {
            SelectableProfileView(
                model: ProfileView.Model(
                    username: user.username,
                    avatarUrl: user.avatarUrl,
                    aboutMyself: user.aboutMyself,
                    topics: user.topics,
                    avatarTapped: { store.dispatch(.avatarTapped) }
                )) {
                    store.dispatch(.likeTapped)
                } rejectHandler: {
                    store.dispatch(.rejectTapped)
                }
                .appLogo(padding: Constants.appLogoInsetTop)
        }
    }
}

// MARK: - Constants

private extension FeedScreen {

    enum Constants {
        static let appLogoInsetTop: CGFloat = 32
        static let noUsersInsetTop: CGFloat = 60
        static let actionButtonSpacing: CGFloat = 20
        static let actionTitleInsetLeading: CGFloat = 16
        static let placeholderImageHeight: CGFloat = 200
    }
}
