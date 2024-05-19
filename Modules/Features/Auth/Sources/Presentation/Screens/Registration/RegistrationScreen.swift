//
//  RegistrationScreen.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import UDFKit
import SwiftUI
import CommonUI

struct RegistrationScreen: View {

    private enum Field {
        case email, password, repeatPassword
    }

    @FocusState private var focusedField: Field?
    @StateObject private var store: StoreOf<RegistrationReducer>

    init(store: StoreOf<RegistrationReducer>) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        AuthView(
            screenTitle: AuthStrings.registration,
            buttonTitle: AuthStrings.register) {
                store.dispatch(.registerTapped)
            } goBackHandler: {
                store.dispatch(.goBackTapped)
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
