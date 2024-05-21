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
        case .emailValidated(let error):
            state.email.error = error
        case .emailChanged(let email):
            state.email.content = email
        case .passwordValidated(let error):
            state.password.error = error
        case .passwordChanged(let password):
            state.password.content = password
        case .repeatPasswordValidated(let error):
            state.repeatPassword.error = error
        case .repeatPasswordChanged(let repeatPassword):
            state.repeatPassword.content = repeatPassword
        }
    }
}
