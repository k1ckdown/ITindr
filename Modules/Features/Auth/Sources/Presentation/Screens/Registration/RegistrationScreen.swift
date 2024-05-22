//
//  RegistrationScreen.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import UDFKit
import SwiftUI
import CommonUI
import Navigation

struct RegistrationScreen: View, NavigationBarHidden {

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
            isLoading: store.state.isLoading,
            screenTitle: AuthStrings.registration,
            buttonTitle: AuthStrings.register,
            buttonEnabled: store.state.isRegisterEnabled) {
                store.dispatch(.registerTapped)
            } goBackHandler: {
                store.dispatch(.goBackTapped)
            } textFields: {
                TextField(AuthStrings.email, text: email)
                    .submitLabel(.next)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .errorFooter(store.state.email)
                    .onSubmit { focusedField = .password }

                TextField(AuthStrings.password, text: password)
                    .submitLabel(.next)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .password)
                    .errorFooter(store.state.password)
                    .onSubmit { focusedField = .repeatPassword }

                TextField(AuthStrings.repeatPassword, text: repeatPassword)
                    .submitLabel(.return)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .errorFooter(store.state.repeatPassword)
                    .focused($focusedField, equals: .repeatPassword)
            }
    }
}

// MARK: - Bindings

private extension RegistrationScreen {

    var email: Binding<String> {
        Binding(store.state.email.content) {
            store.dispatch(.emailChanged($0))
        }
    }

    var password: Binding<String> {
        Binding(store.state.password.content) {
            store.dispatch(.passwordChanged($0))
        }
    }

    var repeatPassword: Binding<String> {
        Binding(store.state.repeatPassword.content) {
            store.dispatch(.repeatPasswordChanged($0))
        }
    }
}
