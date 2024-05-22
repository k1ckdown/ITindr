//
//  AuthView.swift
//  Auth
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI
import CommonUI

struct AuthView<Content: View>: View {

    let isLoading: Bool
    let screenTitle: String
    let buttonTitle: String
    let buttonEnabled: Bool

    let authHandler: () -> Void
    let goBackHandler: () -> Void

    @ViewBuilder let textFields: () -> Content

    var body: some View {
        VStack {
            VStack(spacing: Constants.textFieldSpacing) {
                textFields()

                if isLoading {
                    ProgressView().tintColor()
                }
            }
            .mainTextFieldStyle()
            .screenTitle(screenTitle)
            .frame(maxHeight: .infinity, alignment: .top)

            VStack(spacing: Constants.buttonSpacing) {
                Button(buttonTitle, action: authHandler)
                    .mainButtonStyle()
                    .disabled(buttonEnabled == false)

                Button(AuthStrings.back, action: goBackHandler)
                    .mainButtonStyle(isProminent: false)
            }
        }
        .padding(.horizontal)
        .appLogo()
    }
}

// MARK: - Constants

private extension AuthView {

    enum Constants {
        static var buttonSpacing: CGFloat { 20 }
        static var textFieldSpacing: CGFloat { 20 }
    }
}
