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
        case .emailChanged(let email):
            state.email.content = email
        case .passwordChanged(let password):
            state.password.content = password
        case .repeatPasswordChanged(let repeatPassword):
            state.repeatPassword.content = repeatPassword
        }
    }
}
