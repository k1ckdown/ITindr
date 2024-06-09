//
//  ProfileScreen.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
//

import SwiftUI
import CommonUI

struct ProfileScreen: View {

    var body: some View {
        FullScrollView {
            VStack {
                ProfileView(model: ProfileView.Model(
                    username: "Сергей",
                    avatarUrl: "https://i.playground.ru/p/_I__FEOa_NDhtQE5VzEEtQ.jpeg",
                    aboutMyself: "Начинающий программист",
                    topics: ["Python", "REST", "React JS", "Kotlin", ".NET", "Clean Architecture"].map { .init(id: UUID().uuidString, title: $0) }
                ))
                .frame(maxHeight: .infinity, alignment: .top)

                Button {
                    print("Edit Tapped")
                } label: {
                    HStack(spacing: .zero) {
                        Images.editIcon.swiftUIImage
                        Text("Редактировать").padding(.leading, Constants.editTitleInsetLeading)
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
