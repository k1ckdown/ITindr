//
//  StartScreen.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI
import UDFKit
import CommonUI

struct StartScreen: View {

    @StateObject private var store: StoreOf<StartReducer>

    init(store: StoreOf<StartReducer>) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        VStack {
            VStack(spacing: .zero) {
                Images.appLogo.swiftUIImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.logoWidth, height: Constants.logoHeight)

                Text(AuthStrings.appSlogan)
                    .font(Fonts.bold16)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Colors.accentColor.swiftUIColor)
                    .padding(.top, Constants.sloganInsetTop)

                Images.startPreview.swiftUIImage
                    .padding(.top, Constants.imageInsetTop)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, Constants.contentInsetTop)

            VStack(spacing: Constants.buttonSpacing) {
                Button(AuthStrings.register) {
                    store.dispatch(.registerTapped)
                }
                .mainButtonStyle()

                Button(AuthStrings.logIn) {
                    store.dispatch(.loginTapped)
                }
                .mainButtonStyle(isProminent: false)
            }
            .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

// MARK: - Constants

private extension StartScreen {

    enum Constants {
        static let logoHeight: CGFloat = 48
        static let logoWidth: CGFloat = 166
        static let buttonSpacing: CGFloat = 20
        static let imageInsetTop: CGFloat = 70
        static let sloganInsetTop: CGFloat = 12
        static let contentInsetTop: CGFloat = 50
    }
}
