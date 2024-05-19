//
//  LoginUseCase.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import AuthDomain

final class LoginUseCase {

    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    func execute(_ credentials: LoginCredentials) async throws {
        try await authRepository.logIn(credentials: credentials)
    }
}
