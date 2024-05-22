//
//  LoginScreen.swift
//  Auth
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI
import UDFKit
import CommonUI
import Navigation

struct LoginScreen: View, NavigationBarHidden {

    private enum Field {
        case email, password
    }

    @FocusState private var focusedField: Field?
    @StateObject private var store: StoreOf<LoginReducer>

    init(store: StoreOf<LoginReducer>) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        AuthView(
            isLoading: store.state.isLoading,
            screenTitle: AuthStrings.login,
            buttonTitle: AuthStrings.logIn,
            buttonEnabled: store.state.isLoginEnabled) {
                store.dispatch(.loginTapped)
            } goBackHandler: {
                store.dispatch(.goBackTapped)
            } textFields: {
                TextField(AuthStrings.email, text: email)
                    .submitLabel(.next)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)
                    .errorFooter(store.state.email)
                    .onSubmit { focusedField = .password }

                SecureField(AuthStrings.password, text: password)
                    .submitLabel(.return)
                    .autocorrectionDisabled()
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .errorFooter(store.state.password)
                    .focused($focusedField, equals: .password)
            }
    }
}

// MARK: - Bindings

private extension LoginScreen {

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
}
