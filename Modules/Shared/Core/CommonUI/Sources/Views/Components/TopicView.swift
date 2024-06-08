//
//  TopicView.swift
//  CommonUI
//
//  Created by Ivan Semenov on 08.06.2024.
//

import SwiftUI

public struct TopicView: View {

    let model: Model

    public init(model: Model) {
        self.model = model
    }

    public var body: some View {
        Text(model.title)
            .font(model.isSelected ? Fonts.regular14 : Fonts.bold14)
            .foregroundStyle(model.isSelected ? Colors.accentColor.swiftUIColor : Colors.appWhite.swiftUIColor)
            .padding(.vertical, Constants.insetVertical)
            .padding(.horizontal, Constants.insetHorizontal)
            .background(model.isSelected ? Colors.appWhite.swiftUIColor : Colors.accentColor.swiftUIColor)
            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(model.isSelected ? Colors.accentColor.swiftUIColor : .clear)
            }
    }
}

// MARK: - Model

public extension TopicView {

    struct Model: Hashable, Identifiable {
        public let id: String
        let title: String
        var isSelected = false

        public init(id: String, title: String) {
            self.id = id
            self.title = title
        }
    }
}

// MARK: - Constants

private extension TopicView {

    enum Constants {
        static let cornerRadius: CGFloat = 16
        static let insetVertical: CGFloat = 4
        static let insetHorizontal: CGFloat = 8
    }
}
