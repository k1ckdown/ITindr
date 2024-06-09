//
//  MainTextField.swift
//  CommonUI
//
//  Created by Ivan Semenov on 09.06.2024.
//

import SwiftUI

public struct MainTextField: View {

    @Binding var text: String
    let placeholder: String
    let isSecure: Bool

    public init(_ placeholder: String, text: Binding<String>, isSecure: Bool = false) {
        _text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(Colors.appDarkGray.swiftUIColor)
            }

            if isSecure {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
        .tintColor()
        .font(Fonts.regular16)
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.insetHorizontal)
        .background(Colors.appLightGray.swiftUIColor)
        .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }
}

// MARK: - Constants

private extension MainTextField {

    enum Constants {
        static let height: CGFloat = 56
        static let cornerRadius: CGFloat = 28
        static let insetHorizontal: CGFloat = 24
    }
}
