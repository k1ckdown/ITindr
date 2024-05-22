//
//  RegistrationMiddleware.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit
import AuthDomain
import Validation
import Navigation

@MainActor
protocol RegistrationMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {
    func goBack()
    func showProfileEditor()
}

final class RegistrationMiddleware: Middleware {

    private let registerUseCase: RegisterUseCase
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase
    private weak var delegate: RegistrationMiddlewareDelegate?

    init(
        registerUseCase: RegisterUseCase,
        validateEmailUseCase: ValidateEmailUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase,
        delegate: RegistrationMiddlewareDelegate?
    ) {
        self.registerUseCase = registerUseCase
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
        self.delegate = delegate
    }

    func handle(state: RegistrationState, intent: RegistrationIntent) async -> RegistrationIntent? {
        switch intent {
        case .goBackTapped:
            await delegate?.goBack()
        case .registerTapped:
            return await register(email: state.email.content, password: state.password.content)
        case .emailChanged:
            return .emailValidated(message(try validateEmailUseCase.execute(state.email.content)))
        case .passwordChanged:
            return .passwordValidated(
                error: message(try validatePasswordUseCase.execute(state.password.content)),
                isMatch: matchPasswords(password: state.password.content, repeatPassword: state.repeatPassword.content)
            )
        case .repeatPasswordChanged:
            return .repeatPasswordValidated(matchPasswords(
                password: state.password.content,
                repeatPassword: state.repeatPassword.content
            ))
        case .registered, .registrationFailed, .emailValidated, .repeatPasswordValidated, .passwordValidated: break
        }
        return nil
    }
}

// MARK: - Private methods

private extension RegistrationMiddleware {

    func matchPasswords(password: String, repeatPassword: String) -> Bool {
        password == repeatPassword
    }

    func register(email: String, password: String) async -> RegistrationIntent {
        let user = UserRegister(email: email, password: password)

        do {
            try await registerUseCase.execute(user)
            await delegate?.showProfileEditor()
            return .registered
        } catch {
            await delegate?.showError(error.localizedDescription)
            return .registrationFailed
        }
    }
}
