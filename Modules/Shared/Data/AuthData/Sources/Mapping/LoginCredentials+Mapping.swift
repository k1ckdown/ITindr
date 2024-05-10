//
//  LoginCredentials+Mapping.swift
//  AuthData
//
//  Created by Ivan Semenov on 10.05.2024.
//

import AuthDomain

extension LoginCredentials {

    func toDto() -> LoginCredentialsDTO {
        LoginCredentialsDTO(email: email, password: password)
    }
}
