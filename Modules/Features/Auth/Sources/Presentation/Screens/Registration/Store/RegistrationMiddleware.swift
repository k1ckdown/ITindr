//
//  RegistrationMiddleware.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit
import AuthDomain

@MainActor
protocol RegistrationMiddlewareDelegate: AnyObject, Sendable {
    func goBack()
    //    func showError()
    func showProfileEditor()
}

final class RegistrationMiddleware: Middleware {

    private let registerUseCase: RegisterUseCase
    private weak var delegate: RegistrationMiddlewareDelegate?

    init(registerUseCase: RegisterUseCase, delegate: RegistrationMiddlewareDelegate?) {
        self.registerUseCase = registerUseCase
        self.delegate = delegate
    }

    func handle(state: RegistrationState, intent: RegistrationIntent) async -> RegistrationIntent? {
        switch intent {
        case .goBackTapped:
            await delegate?.goBack()
        case .registerTapped:
            await handleRegisterTap(state)
        case .emailChanged:
            break
        case .passwordChanged:
            break
        case .repeatPasswordChanged:
            break
        default: break
        }
        
        return nil
    }
}


// MARK: - Validation

private extension RegistrationMiddleware {

    func validateEmail(_ email: String) {

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
