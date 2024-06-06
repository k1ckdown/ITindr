//
//  ErrorFooterViewModifier.swift
//  CommonUI
//
//  Created by Ivan Semenov on 21.05.2024.
//

import SwiftUI

struct ErrorFooterViewModifier: ViewModifier {

    let message: String?
    let isPresented: Bool

    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content

            if isPresented, let message {
                Text(message)
                    .foregroundStyle(Colors.accentColor.swiftUIColor)
                    .font(Fonts.medium15)
            }
        }
        .animation(.bouncy, value: message)
    }
}

public extension View {
    func errorFooter(_ message: String?) -> some View {
        modifier(ErrorFooterViewModifier(message: message, isPresented: message != nil))
    }

    func errorFooter(_ textFieldState: TextFieldState) -> some View {
        modifier(ErrorFooterViewModifier(message: textFieldState.error, isPresented: textFieldState.isErrorShowing))
    }
}
