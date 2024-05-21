//
//  ValidatePasswordUseCase.swift
//  Validation
//
//  Created by Ivan Semenov on 21.05.2024.
//

import Foundation

public final class ValidatePasswordUseCase {

    public init() {}

    public func execute(_ password: String) throws {
        guard password.count >= Constants.minPasswordLength else {
            throw PasswordValidationError.invalidPassword
        }
    }
}

// MARK: - Error

private extension ValidatePasswordUseCase {

    enum PasswordValidationError: LocalizedError {
        case invalidPassword

        var errorDescription: String? {
            switch self {
            case .invalidPassword:
                ValidationStrings.invalidPassword(Constants.minPasswordLength)
            }
        }
    }
}

// MARK: - Constants

private extension ValidatePasswordUseCase {

    enum Constants {
        static let minPasswordLength = 8
    }
}
