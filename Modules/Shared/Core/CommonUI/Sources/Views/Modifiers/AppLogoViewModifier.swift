//
//  AppLogoViewModifier.swift
//  Auth
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI

struct AppLogoViewModifier: ViewModifier {

    let padding: CGFloat
    let isShowing: Bool

    func body(content: Content) -> some View {
        VStack {
            if isShowing {
                Images.appLogo.swiftUIImage
                    .padding(.top)
                    .padding(.bottom, padding)
            }

            content
        }
    }
}

public extension View {
    func appLogo(padding: CGFloat = 40, isShowing: Bool = true) -> some View {
        modifier(AppLogoViewModifier(padding: padding, isShowing: isShowing))
    }
}
