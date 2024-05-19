//
//  RegistrationScreen.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI
import CommonUI

struct RegistrationScreen: View {

    var body: some View {
        AuthView(
            screenTitle: AuthStrings.registration,
            buttonTitle: AuthStrings.register) {
                print("auth")
            } goBackHandler: {
                print("go back")
            } textFields: {
                TextField(AuthStrings.email, text: .constant(""))

                TextField(AuthStrings.password, text: .constant(""))

                TextField(AuthStrings.repeatPassword, text: .constant(""))
            }
    }
}

#Preview {
    RegistrationScreen()
}
