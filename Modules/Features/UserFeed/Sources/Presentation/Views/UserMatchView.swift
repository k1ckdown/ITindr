//
//  UserMatchView.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI
import CommonUI

struct UserMatchView: View {

    let cancelHandler: () -> Void
    let writeMessageHandler: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(Constants.backgroundOpacity).ignoresSafeArea()

            VStack {
                VStack(spacing: .zero) {
                    Images.match.swiftUIImage

                    Text(UserFeedStrings.interfacesFitTogether)
                        .font(Fonts.bold16)
                        .foregroundStyle(Colors.appWhite.swiftUIColor)
                        .multilineTextAlignment(.center)
                        .padding(.top, Constants.titleInsetTop)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, Constants.contentInsetTop)

                Button(UserFeedStrings.writeMessage, action: writeMessageHandler)
                    .mainButtonStyle()
                    .padding(.bottom, Constants.messageButtonInsetBottom)
            }
            .padding(.horizontal)
        }
        .contentShape(.rect)
        .onTapGesture(perform: cancelHandler)
        .background(ClearBackgroundView())
    }
}

// MARK: - Constants

private extension UserMatchView {

    enum Constants {
        static let backgroundOpacity = 0.7
        static let titleInsetTop: CGFloat = 16
        static let contentInsetTop: CGFloat = 110
        static let messageButtonInsetBottom: CGFloat = 37
    }
}
