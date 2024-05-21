//
//  ValidateUsernameUseCase.swift
//  Validation
//
//  Created by Ivan Semenov on 21.05.2024.
//

import Foundation

public final class ValidateUsernameUseCase {

    public func execute(_ username: String) throws {
        let usernamePredicate = NSPredicate(
            format: Constants.formatString,
            Constants.regex
        )

        guard usernamePredicate.evaluate(with: username) else {
            throw UsernameValidationError.invalidUsername
        }
    }
}

// MARK: - Error

private extension ValidateUsernameUseCase {

    enum UsernameValidationError: LocalizedError {
        case invalidUsername

        var errorDescription: String? {
            switch self {
            case .invalidUsername: ValidationStrings.invalidUsername
            }
        }
    }
}

// MARK: - Constants

private extension ValidateUsernameUseCase {

    enum Constants {
        static let regex = "[a-zA-Z0-9]+"
        static let formatString = "SELF MATCHES %@"
    }
}
