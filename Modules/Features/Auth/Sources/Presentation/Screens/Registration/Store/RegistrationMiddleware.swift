//
//  RegistrationMiddleware.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit

protocol RegistrationMiddlewareDelegate: AnyObject {
    func goBack()
    func showProfileEditor()
}

final class RegistrationMiddleware: Middleware {

    private let registerUseCase: RegisterUseCase
    private weak var delegate: RegistrationMiddlewareDelegate?

    init(registerUseCase: RegisterUseCase, delegate: RegistrationMiddlewareDelegate?) {
        self.registerUseCase = registerUseCase
        self.delegate = delegate
    }

    func handle(state: RegistrationState, intent: RegistrationIntent) -> RegistrationIntent? {
        switch intent {
        case .goBackTapped:
            delegate?.goBack()
        case .registerTapped:
            delegate?.showProfileEditor()
        case .emailChanged:
            break
        case .passwordChanged:
            break
        case .repeatPasswordChanged:
            break
        }

        return nil
    }
}
