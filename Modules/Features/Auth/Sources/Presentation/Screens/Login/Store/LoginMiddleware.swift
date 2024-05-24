//
//  LoginMiddleware.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 22.05.2024.
//

import UDFKit
import Validation
import AuthDomain
import Navigation

@MainActor
protocol LoginMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func finish()
    func goBack()
}

final class LoginMiddleware: Middleware {

    private let loginUseCase: LoginUseCase
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase
    private weak var delegate: LoginMiddlewareDelegate?

    init(
        loginUseCase: LoginUseCase,
        validateEmailUseCase: ValidateEmailUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase,
        delegate: LoginMiddlewareDelegate?
    ) {
        self.loginUseCase = loginUseCase
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
        self.delegate = delegate
    }

    func handle(state: LoginState, intent: LoginIntent) async -> LoginIntent? {
        switch intent {
        case .goBackTapped:
            await delegate?.goBack()
        case .loginTapped:
            return await login(email: state.email.content, password: state.password.content)
        case .emailChanged(let email):
            return .emailValidated(message(try validateEmailUseCase.execute(email)))
        case .passwordChanged(let password):
            return .passwordValidated(message(try validatePasswordUseCase.execute(password)))
        case .loggedIn, .loginFailed, .emailValidated, .passwordValidated: break
        }
        return nil
    }
}

// MARK: - Private methods

private extension LoginMiddleware {

    func login(email: String, password: String) async -> LoginIntent {
        let credentials = LoginCredentials(email: email, password: password)

        do {
            try await loginUseCase.execute(credentials)
            await delegate?.finish()
            return .loggedIn
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .loginFailed
        }
    }
}
