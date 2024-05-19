//
//  RegisterUseCase.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 19.05.2024.
//

import AuthDomain

final class RegisterUseCase {

    private let authRepository: AuthRepositoryProtocol

    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }

    func execute(_ user: UserRegister) async throws {
        try await authRepository.register(user: user)
    }
}
