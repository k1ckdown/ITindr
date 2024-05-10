//
//  UserRegister.swift
//  AuthDomain
//
//  Created by Ivan Semenov on 10.05.2024.
//

public struct UserRegister {
    public let email: String
    public let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
