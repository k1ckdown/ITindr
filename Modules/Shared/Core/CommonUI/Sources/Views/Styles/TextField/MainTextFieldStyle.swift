//
//  MainTextFieldStyle.swift
//  CommonUI
//
//  Created by Ivan Semenov on 18.05.2024.
//

import SwiftUI

struct MainTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .tintColor()
            .font(Fonts.regular16)
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.insetHorizontal)
            .background(Colors.appLightGray.swiftUIColor)
            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }
}

// MARK: - Constants

private extension MainTextFieldStyle {

    enum Constants {
        static let height: CGFloat = 56
        static let cornerRadius: CGFloat = 28
        static let insetHorizontal: CGFloat = 24
    }
}

public extension View {
    func mainTextFieldStyle() -> some View {
        textFieldStyle(MainTextFieldStyle())
    }
}
