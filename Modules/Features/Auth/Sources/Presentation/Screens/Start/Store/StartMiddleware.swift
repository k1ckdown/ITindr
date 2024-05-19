//
//  StartMiddleware.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit

protocol StartMiddlewareDelegate: AnyObject {
    func showLogin()
    func showRegistration()
}

final class StartMiddleware: Middleware {

    private weak var delegate: StartMiddlewareDelegate?

    init(delegate: StartMiddlewareDelegate?) {
        self.delegate = delegate
    }

    func handle(state: StartState, intent: StartIntent) -> StartIntent? {
        switch intent {
        case .loginTapped: delegate?.showLogin()
        case .registerTapped: delegate?.showRegistration()
        }

        return nil
    }
}
