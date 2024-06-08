//
//  SelectableProfileView.swift
//  CommonUI
//
//  Created by Ivan Semenov on 07.06.2024.
//

import SwiftUI

public struct SelectableProfileView: View {

    let model: ProfileView.Model
    let likeHandler: () -> Void
    let rejectHandler: () -> Void

    public init(model: ProfileView.Model, likeHandler: @escaping () -> Void, rejectHandler: @escaping () -> Void) {
        self.model = model
        self.likeHandler = likeHandler
        self.rejectHandler = rejectHandler
    }

    public var body: some View {
        VStack {
            ProfileView(model: model)
                .frame(maxHeight: .infinity, alignment: .top)

            actionButtons()
                .padding(.top, Constants.actionButtonsInsetTop)
                .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

// MARK: - Views

private extension SelectableProfileView {

    func actionButtonLabel(title: String, image: Image) -> some View {
        HStack(spacing: .zero) {
            image.renderingMode(.template)
            Text(title).padding(.leading, Constants.actionTitleInsetLeading)
        }
    }

    func actionButtons() -> some View {
        HStack(spacing: Constants.actionButtonSpacing) {
            Button(action: rejectHandler) {
                actionButtonLabel(title: Strings.reject, image: Images.xCircleIcon.swiftUIImage)
            }
            .mainButtonStyle(isProminent: false)


            Button(action: likeHandler) {
                actionButtonLabel(title: Strings.like, image: Images.heartIcon.swiftUIImage)
            }
            .mainButtonStyle()
        }
    }
}

// MARK: - Constants

private extension SelectableProfileView {

    enum Constants {
        static let actionButtonSpacing: CGFloat = 20
        static let actionButtonsInsetTop: CGFloat = 32
        static let actionTitleInsetLeading: CGFloat = 16
    }
}
