//
//  StartScreen.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI
import CommonUI

struct StartScreen: View {

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

                }
                .mainButtonStyle()

                Button(AuthStrings.logIn) {

                }
                .mainButtonStyle(isProminent: false)
            }
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
        static let contentInsetTop: CGFloat = 85
    }
}

#Preview {
    StartScreen()
}
