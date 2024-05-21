//
//  RegistrationReducer.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UDFKit

struct RegistrationReducer: Reducer {

    func reduce(state: inout RegistrationState, intent: RegistrationIntent) {
        switch intent {
        case .goBackTapped, .registerTapped: break
        case .emailFailed(let message):
            state.email.error = message
        case .emailChanged(let email):
            state.email.content = email
        case .passwordFailed(let message):
            state.password.error = message
        case .passwordChanged(let password):
            state.password.content = password
        case .repeatPasswordFailed(let message):
            state.repeatPassword.error = message
        case .repeatPasswordChanged(let repeatPassword):
            state.repeatPassword.content = repeatPassword
        }
    }
}
