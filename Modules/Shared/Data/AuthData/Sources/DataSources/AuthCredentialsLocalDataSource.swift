//
//  AuthCredentialsLocalDataSource.swift
//  AuthData
//
//  Created by Ivan Semenov on 9.05.2024.
//

import Network
import Keychain

public protocol AuthCredentialsLocalDataSourceProtocol: AnyObject {
    func delete() throws
    func retrieve() throws -> AuthCredentials
    func save(_ credential: AuthCredentials) throws
    func update(_ credential: AuthCredentials) throws
}

// MARK: - KeychainStorage + AuthCredentialsLocalDataSourceProtocol

extension KeychainStorage: AuthCredentialsLocalDataSourceProtocol {

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
