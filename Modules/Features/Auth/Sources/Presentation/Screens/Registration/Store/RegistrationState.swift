//
//  RegistrationState.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

struct TextFieldState: Equatable {
    var content = ""
    var error: String?

    var isErrorShowing: Bool {
        self.error != nil
    }
}

struct RegistrationState: Equatable {
    var isLoading = false

    var email = TextFieldState()
    var password = TextFieldState()
    var repeatPassword = TextFieldState()

    var isRegisterDisabled: Bool {
        false
    }
}

enum RegistrationIntent: Equatable {
    case goBackTapped
    case registerTapped

    case emailChanged(String)
    case passwordChanged(String)
    case repeatPasswordChanged(String)
}
