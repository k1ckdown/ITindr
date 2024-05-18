//
//  MainButtonStyle.swift
//  CommonUI
//
//  Created by Ivan Semenov on 18.05.2024.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Fonts.bold16)
            .foregroundStyle(Colors.appWhite.swiftUIColor)
            .frame(height: Constants.height)
            .frame(maxWidth: .infinity)
            .background(background)
            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
            .opacity(isEnabled ? Constants.opacityEnabled : Constants.opacityDisabled)
            .overlay {
                if configuration.isPressed {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill(.black.opacity(Constants.opacityPressed))
                }
            }
            .scaleEffect(configuration.isPressed ? Constants.scaleEffectPressed : Constants.scaleEffect)
            .animation(.easeOut(duration: Constants.animationDuration), value: configuration.isPressed)
    }

    private var background: LinearGradient {
        LinearGradient(
            colors: [Colors.accentColor.swiftUIColor, Colors.appPurple.swiftUIColor],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

// MARK: - Constants

private extension MainButtonStyle {

    enum Constants {
        static let height: CGFloat = 56
        static let cornerRadius: CGFloat = 28

        static let scaleEffect: CGFloat = 1
        static let scaleEffectPressed: CGFloat = 0.97

        static let opacityPressed = 0.05
        static let opacityDisabled = 0.85
        static let opacityEnabled: Double = 1

        static let animationDuration: TimeInterval = 0.1
    }
}

public extension View {
    func mainButtonStyle() -> some View {
        self.buttonStyle(MainButtonStyle())
    }
}
