//
//  LoginReducer.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 22.05.2024.
//

import UDFKit

struct LoginReducer: Reducer {
    
    func reduce(state: inout LoginState, intent: LoginIntent) {
        switch intent {
        case .loggedIn, .loginFailed:
            state.isLoading = false
        case .loginTapped:
            state.isLoading = true
        case .emailChanged(let email):
            state.email.content = email
        case .passwordChanged(let password):
            state.password.content = password
        case .passwordValidated(let error):
            state.password.error = error
        case .emailValidated(let error):
            state.email.error = error
        case .goBackTapped: break
        }
    }
}
