//
//  LoginScreen.swift
//  Auth
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI

struct LoginScreen: View {

    private enum Field {
        case email, password
    }

    @FocusState private var focusedField: Field?

    var body: some View {
        AuthView(
            screenTitle: AuthStrings.login,
            buttonTitle: AuthStrings.logIn) {
                print("log in")
            } goBackHandler: {
                print("go back")
            } textFields: {
                TextField(AuthStrings.email, text: .constant(""))
                    .submitLabel(.next)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .onSubmit { focusedField = .password }

                SecureField(AuthStrings.password, text: .constant(""))
                    .submitLabel(.return)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .password)
            }
    }
}

#Preview {
    LoginScreen()
}
