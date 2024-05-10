//
//  TokenStorage.swift
//  Network
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Keychain
import Network

public protocol AuthCredentialsStorageProtocol: AnyObject {
    func delete() throws
    func retrieve() throws -> AuthCredentials
    func save(_ credential: AuthCredentials) throws
    func update(_ credential: AuthCredentials) throws
}

// MARK: - KeychainStorage + AuthCredentialsStorageProtocol

extension KeychainStorage: AuthCredentialsStorageProtocol {

    private enum Key: String {
        case authCredentials
    }

    public func delete() throws {
        try delete(key: Key.authCredentials.rawValue)
    }

    public func retrieve() throws -> AuthCredentials {
        try retrieve(key: Key.authCredentials.rawValue)
    }

    public func update(_ credentials: AuthCredentials) throws {
        try update(credentials, key: Key.authCredentials.rawValue)
    }

    public func save(_ credentials: AuthCredentials) throws {
        try save(credentials, key: Key.authCredentials.rawValue)
    }
}
