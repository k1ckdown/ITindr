//
//  StartMiddleware.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit

@MainActor
protocol StartMiddlewareDelegate: AnyObject, Sendable {
    func showLogin()
    func showRegistration()
}

final class StartMiddleware: Middleware {

    private weak var delegate: StartMiddlewareDelegate?

    init(delegate: StartMiddlewareDelegate?) {
        self.delegate = delegate
    }

    func handle(state: StartState, intent: StartIntent) async -> StartIntent? {
        switch intent {
        case .loginTapped: await delegate?.showLogin()
        case .registerTapped: await delegate?.showRegistration()
        }

        return nil
    }
}
