//
//  UseCaseFactory.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import AuthDomain

final class UseCaseFactory {
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
    }
}

// MARK: - Public methods

extension UseCaseFactory {
    
    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(authRepository: authRepository)
    }
    
    func makeRegisterUseCase() -> RegisterUseCase {
        RegisterUseCase(authRepository: authRepository)
    }
}
