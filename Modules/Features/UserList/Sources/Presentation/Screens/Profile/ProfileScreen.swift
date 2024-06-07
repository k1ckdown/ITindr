//
//  ProfileScreen.swift
//  UserList
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UDFKit
import SwiftUI
import CommonUI

struct ProfileScreen: View {

    @StateObject private var store: StoreOf<ProfileReducer>

    init(store: StoreOf<ProfileReducer>) {
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

    private func loadedView(_ user: ProfileState.User) -> some View {
        SelectableProfileView(
            model: ProfileView.Model(
                username: user.username,
                avatarUrl: user.avatarUrl,
                aboutMyself: user.aboutMyself,
                topics: user.topics
            )) {
                store.dispatch(.likeTapped)
            } rejectHandler: {
                store.dispatch(.rejectTapped)
            }
            .padding(.top, Constants.contentInsetTop)
    }
}

// MARK: - Constants

private extension ProfileScreen {

    enum Constants {
        static let contentInsetTop: CGFloat = 60
    }
}
