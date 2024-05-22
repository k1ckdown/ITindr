//
//  ScreenFactory.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit

final class ScreenFactory {

    private let useCaseFactory: UseCaseFactory

    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
}

// MARK: - Public methods

@MainActor
extension ScreenFactory {

    func makeStartScreen(middlewareDelegate: StartMiddlewareDelegate?) -> StartScreen {
        let reducer = StartReducer()
        let initialState = StartState()
        let middleware = StartMiddleware(delegate: middlewareDelegate)

        let store = Store(initialState: initialState, reducer: reducer, middleware: middleware)
        return StartScreen(store: store)
    }

    func makeLoginScreen(middlewareDelegate: LoginMiddlewareDelegate?) -> LoginScreen {
        let reducer = LoginReducer()
        let initialState = LoginState()
        let middleware = LoginMiddleware(
            loginUseCase: useCaseFactory.makeLoginUseCase(),
            validateEmailUseCase: useCaseFactory.makeValidateEmailUseCase(),
            validatePasswordUseCase: useCaseFactory.makeValidatePasswordUseCase(),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: initialState, reducer: reducer, middleware: middleware)
        return LoginScreen(store: store)
    }

    func makeRegistrationScreen(middlewareDelegate: RegistrationMiddlewareDelegate?) -> RegistrationScreen {
        let reducer = RegistrationReducer()
        let initialState = RegistrationState()
        let middleware = RegistrationMiddleware(
            registerUseCase: useCaseFactory.makeRegisterUseCase(),
            validateEmailUseCase: useCaseFactory.makeValidateEmailUseCase(),
            validatePasswordUseCase: useCaseFactory.makeValidatePasswordUseCase(),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: initialState, reducer: reducer, middleware: middleware)
        return RegistrationScreen(store: store)
    }
}
