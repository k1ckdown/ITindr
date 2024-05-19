//
//  AppLogoViewModifier.swift
//  Auth
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI

struct AppLogoViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        VStack {
            Images.appLogo.swiftUIImage
                .padding(.top)
                .padding(.bottom, Constants.insetBottom)

            content
        }
    }
}

// MARK: - Constants

private extension AppLogoViewModifier {

    enum Constants {
        static let insetBottom: CGFloat = 40
    }
}

public extension View {
    func appLogo() -> some View {
        modifier(AppLogoViewModifier())
    }
}
