//
//  RegistrationScreen.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI
import CommonUI

struct RegistrationScreen: View {
    
    private enum Field {
        case email, password, repeatPassword
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        AuthView(
            screenTitle: AuthStrings.registration,
            buttonTitle: AuthStrings.register) {
                print("auth")
            } goBackHandler: {
                print("go back")
            } textFields: {
                TextField(AuthStrings.email, text: .constant(""))
                    .submitLabel(.next)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .onSubmit { focusedField = .password }
                
                TextField(AuthStrings.password, text: .constant(""))
                    .submitLabel(.next)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .password)
                    .onSubmit { focusedField = .repeatPassword }
                
                TextField(AuthStrings.repeatPassword, text: .constant(""))
                    .submitLabel(.return)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .repeatPassword)
            }
    }
}

#Preview {
    RegistrationScreen()
}
