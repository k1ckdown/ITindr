//
//  RegistrationState.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import CommonUI

struct RegistrationState: Equatable {
    var isLoading = false

    var email = TextFieldState()
    var password = TextFieldState()
    var repeatPassword = TextFieldState()

    var isRegisterEnabled: Bool {
        email.isValid && password.isValid && repeatPassword.isValid
    }
}

enum RegistrationIntent: Equatable {
    case goBackTapped
    case registerTapped

    case emailFailed(String)
    case passwordFailed(String)
    case repeatPasswordFailed(String)

    case emailChanged(String)
    case passwordChanged(String)
    case repeatPasswordChanged(String)
}
