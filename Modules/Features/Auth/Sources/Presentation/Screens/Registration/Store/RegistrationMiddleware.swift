//
//  RegistrationMiddleware.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit
import AuthDomain
import Validation

@MainActor
protocol RegistrationMiddlewareDelegate: AnyObject, Sendable {
    func goBack()
    func showProfileEditor()
    func showError(_ message: String)
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
            await handleRegisterTap(state)
        case .emailChanged:
            return .emailValidated(validateEmail(state.email.content))
        case .passwordChanged:
            return .passwordValidated(validatePassword(state.password.content))
        case .repeatPasswordChanged:
            return .repeatPasswordValidated(matchPasswords(
                password: state.password.content,
                repeatPassword: state.repeatPassword.content
            ))
        default: break
        }

        return nil
    }
}

// MARK: - Register

private extension RegistrationMiddleware {

    func register(email: String, password: String) async throws {
        let user = UserRegister(email: email, password: password)
        try await registerUseCase.execute(user)
    }

    func handleRegisterTap(_ state: RegistrationState) async {
        try? await register(email: state.email.content, password: state.password.content)
        await delegate?.showProfileEditor()
    }
}


// MARK: - Validation

private extension RegistrationMiddleware {

    func matchPasswords(password: String, repeatPassword: String) -> String? {
        password == repeatPassword ? nil : AuthStrings.invalidConfirmPassword
    }

    func validateEmail(_ email: String) -> String? {
        validate {
            try validateEmailUseCase.execute(email)
        }
    }
    
    func validatePassword(_ password: String) -> String? {
        validate {
            try validatePasswordUseCase.execute(password)
        }
    }

    func validate(_ block: () throws -> Void) -> String? {
        do {
            try block()
            return nil
        } catch {
            return error.localizedDescription
        }
    }
}
