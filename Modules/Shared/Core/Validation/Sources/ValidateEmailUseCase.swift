//
//  ValidateEmailUseCase.swift
//  Validation
//
//  Created by Ivan Semenov on 21.05.2024.
//

import Foundation

public final class ValidateEmailUseCase {

    public func execute(_ email: String) throws {
        guard isUsernameValid(email) else {
            throw EmailValidationError.invalidUsername
        }

        guard isContainsKeySign(email) else {
            throw EmailValidationError.missingKeySign
        }

        guard isDomainValid(email) else {
            throw EmailValidationError.invalidDomainPart
        }

        guard isTopLevelDomainValid(email) else {
            throw EmailValidationError.invalidTopLevelDomain
        }
    }
}

// MARK: - Private methods

private extension ValidateEmailUseCase {

    func isContainsKeySign(_ email: String) -> Bool {
        email.contains("@")
    }

    func getUsername(_ email: String) -> String {
        email.components(separatedBy: "@").first ?? ""
    }

    func getTopLevelDomain(_ email: String) -> String {
        email.components(separatedBy: ".").last ?? ""
    }

    func getDomain(_ email: String) -> String {
        guard let index = email.firstIndex(of: "@") else { return "" }
        let substring = email[email.index(after: index)...]

        return substring.components(separatedBy: ".").first ?? ""
    }

    func isUsernameValid(_ email: String) -> Bool {
        let usernamePredicate = NSPredicate(
            format: Constants.formatString,
            Constants.usernameRegex
        )

        return usernamePredicate.evaluate(with: getUsername(email))
    }

    func isDomainValid(_ email: String) -> Bool {
        let domainPredicate = NSPredicate(
            format: Constants.formatString,
            Constants.domainRegex
        )

        return domainPredicate.evaluate(with: getDomain(email))
    }

    func isTopLevelDomainValid(_ email: String) -> Bool {
        let topLevelDomainPredicate = NSPredicate(
            format: Constants.formatString,
            Constants.topLevelDomainRegex
        )

        return topLevelDomainPredicate.evaluate(with: getTopLevelDomain(email))
    }
}

// MARK: - Error

private extension ValidateEmailUseCase {

    enum EmailValidationError: LocalizedError {
        case missingKeySign
        case invalidUsername
        case invalidDomainPart
        case invalidTopLevelDomain

        var errorDescription: String? {
            switch self {
            case .missingKeySign: ValidationStrings.missingKeySign
            case .invalidUsername: ValidationStrings.invalidEmailUsername
            case .invalidDomainPart: ValidationStrings.invalidDomainPart
            case .invalidTopLevelDomain: ValidationStrings.invalidTopLevelDomain
            }
        }
    }
}

// MARK: - Constants

private extension ValidateEmailUseCase {

    enum Constants {
        static let domainRegex = "[A-Za-z0-9.-]+"
        static let usernameRegex = "[A-Z0-9a-z._%+-]+"
        static let topLevelDomainRegex = "^[A-Za-z]{2,64}"
        static let formatString = "SELF MATCHES %@"
    }
}
