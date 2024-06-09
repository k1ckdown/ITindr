//
//  ProfileMiddleware.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UDFKit
import Navigation
import ProfileDomain

@MainActor
protocol ProfileMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goToEditor(_ user: UserProfile)
}

final class ProfileMiddleware: Middleware {

    func handle(state: ProfileState, intent: ProfileIntent) async -> ProfileIntent? {
        nil
    }
}
