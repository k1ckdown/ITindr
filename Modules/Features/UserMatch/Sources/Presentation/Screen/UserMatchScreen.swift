//
//  UserMatchScreen.swift
//  UserMatch
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UDFKit
import SwiftUI
import CommonUI

struct UserMatchScreen: View {

    let cancelHandler: (() -> Void)?
    @StateObject private var store: StoreOf<UserMatchReducer>

    init(store: StoreOf<UserMatchReducer>, cancelHandler: (() -> Void)? = nil) {
        _store = StateObject(wrappedValue: store)
        self.cancelHandler = cancelHandler
    }

    var body: some View {
        ZStack {
            Color.black.opacity(Constants.backgroundOpacity).ignoresSafeArea()

            VStack {
                VStack(spacing: .zero) {
                    Images.match.swiftUIImage

                    Text(UserMatchStrings.interfacesFitTogether)
                        .font(Fonts.bold16)
                        .foregroundStyle(Colors.appWhite.swiftUIColor)
                        .multilineTextAlignment(.center)
                        .padding(.top, Constants.titleInsetTop)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, Constants.contentInsetTop)

                Button(UserMatchStrings.writeMessage) {
                    store.dispatch(.writeMessageTapped)
                }
                .mainButtonStyle()
                .padding(.bottom, Constants.messageButtonInsetBottom)
            }
            .padding(.horizontal)
        }
        .contentShape(.rect)
        .onTapGesture(perform: cancelHandler ?? {})
        .background(ClearBackgroundView())
    }
}

// MARK: - Constants

private extension UserMatchScreen {

    enum Constants {
        static let backgroundOpacity = 0.7
        static let titleInsetTop: CGFloat = 16
        static let contentInsetTop: CGFloat = 110
        static let messageButtonInsetBottom: CGFloat = 37
    }
}
