//
//  ProfileEditorMiddleware.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit
import Navigation

@MainActor
protocol ProfileEditorMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToNext()
}

final class ProfileEditorMiddleware: Middleware {

    private weak var delegate: ProfileEditorMiddlewareDelegate?

    init(delegate: ProfileEditorMiddlewareDelegate?) {
        self.delegate = delegate
    }

    func handle(state: ProfileEditorState, intent: ProfileEditorIntent) async -> ProfileEditorIntent? {
        switch intent {
        case .saveTapped: await delegate?.goToNext()
        case .choosePhotoTapped, .deletePhotoTapped, .photoChosen,
                .nameChanged, .aboutMyselfChanged, .sourceTypeSelected: break
        }

        return nil
    }
}
