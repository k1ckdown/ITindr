//
//  KeychainStorage.swift
//  Keychain
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Security
import Foundation

public final class KeychainStorage {

    public enum KeychainError: Error {
        case invalidData
        case itemNotFound
        case duplicateItem
        case unexpectedStatus(OSStatus)
    }

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    public init() {}
}

// MARK: - Public methods

public extension KeychainStorage {

    func delete(key: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess else {
            throw self.convertError(status)
        }
    }

    func save<T: Encodable>(_ value: T, key: String) throws {
        let data = try self.encoder.encode(value)

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: data,
            kSecAttrAccount: key
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        guard status == errSecSuccess else {
            throw self.convertError(status)
        }
    }

    func update<T: Encodable>(_ value: T, key: String) throws {
        let data = try self.encoder.encode(value)

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else {
            throw self.convertError(status)
        }
    }

    func retrieve<T: Decodable>(key: String) throws -> T {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            throw self.convertError(status)
        }

        guard let data = result as? Data else {
            throw KeychainError.invalidData
        }

        return try self.decoder.decode(T.self, from: data)
    }
}

// MARK: - Private methods

private extension KeychainStorage {

    func convertError(_ status: OSStatus) -> KeychainError {
        switch status {
        case errSecItemNotFound:
                .itemNotFound
        case errSecDataTooLarge:
                .invalidData
        case errSecDuplicateItem:
                .duplicateItem
        default:
                .unexpectedStatus(status)
        }
    }
}
