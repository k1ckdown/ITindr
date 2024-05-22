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
        case .registered, .registrationFailed:
            state.isLoading = false
        case .emailValidated(let error):
            state.email.error = error
        case .emailChanged(let email):
            state.email.content = email
        case .passwordValidated(let error, let isMatch):
            state.password.error = error
            state.repeatPassword.error = getRepeatPasswordError(isMatch: isMatch)
        case .passwordChanged(let password):
            state.password.content = password
        case .repeatPasswordValidated(let isMatch):
            state.repeatPassword.error = getRepeatPasswordError(isMatch: isMatch)
        case .repeatPasswordChanged(let repeatPassword):
            state.repeatPassword.content = repeatPassword
        }
    }

    private func getRepeatPasswordError(isMatch: Bool) -> String? {
        isMatch ? nil : AuthStrings.invalidConfirmPassword
    }
}
