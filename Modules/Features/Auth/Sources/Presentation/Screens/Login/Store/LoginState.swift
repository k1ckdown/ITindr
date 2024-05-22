//
//  LoginState.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 22.05.2024.
//

import CommonUI

struct LoginState: Equatable {
    var isLoading = false
    var email = TextFieldState()
    var password = TextFieldState()

    var isLoginEnabled: Bool {
        email.isValid && password.isValid
    }
}

enum LoginIntent: Equatable {
    case loggedIn
    case loginFailed
    case loginTapped
    case goBackTapped

    case emailChanged(String)
    case passwordChanged(String)

    case emailValidated(String?)
    case passwordValidated(String?)
}
