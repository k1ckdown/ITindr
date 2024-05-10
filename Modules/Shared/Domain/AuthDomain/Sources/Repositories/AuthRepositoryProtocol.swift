//
//  AuthRepositoryProtocol.swift
//  AuthDomain
//
//  Created by Ivan Semenov on 10.05.2024.
//

public protocol AuthRepositoryProtocol: AnyObject {
    func isLoggedIn() -> Bool
    func logOut() async throws
    func register(user: UserRegister) async throws
    func logIn(credentials: LoginCredentials) async throws
}
