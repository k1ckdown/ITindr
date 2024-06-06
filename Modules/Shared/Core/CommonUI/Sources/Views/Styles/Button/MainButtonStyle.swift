//
//  MainButtonStyle.swift
//  CommonUI
//
//  Created by Ivan Semenov on 18.05.2024.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {

    let isProminent: Bool
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Fonts.bold16)
            .foregroundStyle(textColor)
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
            .shadow(
                color: Constants.shadowColor,
                radius: isProminent ? 0 : Constants.shadowRadius,
                y: isProminent ? 0 : Constants.shadowY
            )
    }

    private var textColor: Color {
        (isProminent ? Colors.appWhite : Colors.accentColor).swiftUIColor
    }

    @ViewBuilder
    private var background: some View {
        if isProminent {
            LinearGradient(
                colors: [Colors.accentColor.swiftUIColor, Colors.appPurple.swiftUIColor],
                startPoint: .leading,
                endPoint: .trailing
            )
        } else {
            Colors.appWhite.swiftUIColor
        }
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

        static let shadowY: CGFloat = 10
        static let shadowRadius: CGFloat = 20
        static let shadowColor = Color.black.opacity(0.15)

        static let animationDuration: TimeInterval = 0.1
    }
}

public extension View {
    func mainButtonStyle(isProminent: Bool = true) -> some View {
        self.buttonStyle(MainButtonStyle(isProminent: isProminent))
    }
}
