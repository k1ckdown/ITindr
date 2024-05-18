//
//  ScreenTitleViewModifier.swift
//  CommonUI
//
//  Created by Ivan Semenov on 18.05.2024.
//

import SwiftUI

struct ScreenTitleViewModifier: ViewModifier {

    let text: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(text)
                .font(Fonts.bold24)
                .foregroundStyle(Colors.accentColor.swiftUIColor)

            content.padding(.top, Constants.contentInsetTop)
        }
    }
}

// MARK: - Constants

private extension ScreenTitleViewModifier {

    enum Constants {
        static let contentInsetTop: CGFloat = 20
    }
}

public extension View {
    func screenTitle(_ text: String) -> some View {
        modifier(ScreenTitleViewModifier(text: text))
    }
}
