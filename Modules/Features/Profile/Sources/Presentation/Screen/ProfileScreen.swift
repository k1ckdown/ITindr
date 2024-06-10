//
//  ProfileScreen.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
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
        case .loaded(let viewData):
            loadedView(viewData)
        }
    }
}

// MARK: - Views

private extension ProfileScreen {

    func loadedView(_ viewData: ProfileState.ViewData) -> some View {
        FullScrollView {
            VStack {
                ProfileView(model: ProfileView.Model(
                    username: viewData.username,
                    avatarUrl: viewData.avatarUrl,
                    aboutMyself: viewData.aboutMyself,
                    topics: viewData.topics,
                    avatarData: viewData.avatarData
                ))
                .frame(maxHeight: .infinity, alignment: .top)

                Button {
                    store.dispatch(.editTapped)
                } label: {
                    HStack(spacing: .zero) {
                        Images.editIcon.swiftUIImage
                        Text("Edit").padding(.leading, Constants.editTitleInsetLeading)
                    }
                }
                .mainButtonStyle(isProminent: false)
                .padding(.horizontal, Constants.editButtonInsetHorizontal)
                .padding(.bottom, Constants.editButtonInsetBottom)
            }
            .padding(.horizontal, Constants.contentInsetHorizontal)
            .padding(.top, Constants.contentInsetTop)
        }
    }
}

// MARK: - Constants

private extension ProfileScreen {

    enum Constants {
        static let contentInsetTop: CGFloat = 40
        static let contentInsetHorizontal: CGFloat = 40

        static let editTitleInsetLeading: CGFloat = 16
        static let editButtonInsetBottom: CGFloat = 30
        static let editButtonInsetHorizontal: CGFloat = 35
    }
}
