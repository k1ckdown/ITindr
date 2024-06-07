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
        Group {
            if let user { profileView(user) } else { placeholderView() }
        }
        .appLogo(padding: Constants.appLogoInsetTop)
    }
    
    func placeholderView() -> some View {
        Text("No users").frame(maxHeight: .infinity)
    }
    
    func profileView(_ user: FeedState.User) -> some View {
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
    }
}

// MARK: - Constants

private extension FeedScreen {
    
    enum Constants {
        static let appLogoInsetTop: CGFloat = 32
        static let actionButtonSpacing: CGFloat = 20
        static let actionTitleInsetLeading: CGFloat = 16
    }
}
