//
//  AuthRepository.swift
//  AuthData
//
//  Created by Ivan Semenov on 10.05.2024.
//

import Network
import AuthDomain

public final class AuthRepository {

    enum AuthError: Error {
        case unauthorized
    }

    public var logOutHandler: (() -> Void)?
    private let networkService: NetworkServiceProtocol
    private let credentialsLocalDataSource: AuthCredentialsLocalDataSourceProtocol

    public init(networkService: NetworkServiceProtocol, credentialsLocalDataSource: AuthCredentialsLocalDataSourceProtocol) {
        self.networkService = networkService
        self.credentialsLocalDataSource = credentialsLocalDataSource
    }
}

// MARK: - AuthRepositoryProtocol

extension AuthRepository: AuthRepositoryProtocol {

    public func isLoggedIn() -> Bool {
        let authCredential = try? retrieveCredentials()
        return authCredential != nil
    }

    public func register(user: UserRegister) async throws {
        let userDto = user.toDto()
        let networkConfig = AuthNetworkConfig.register(userDto)

        try await authenticate(networkConfig: networkConfig)
    }

    public func logIn(credentials: LoginCredentials) async throws {
        let credentialsDto = credentials.toDto()
        let networkConfig = AuthNetworkConfig.login(credentialsDto)

        try await authenticate(networkConfig: networkConfig)
    }

    public func logOut() async throws {
        let networkConfig = AuthNetworkConfig.logout
        try await networkService.request(config: networkConfig, authorized: true)
        try handleLogout()
    }
}

// MARK: - AuthInterceptorDelegate

extension AuthRepository: AuthInterceptorDelegate {

    public func handleTokenExpiration() throws {
        try handleLogout()
    }

    public func retrieveCredentials() throws -> AuthCredentials {
        try credentialsLocalDataSource.retrieve()
    }

    public func refresh() async throws -> AuthCredentials {
        let credentials = try retrieveCredentials()
        let authCredentials = try await refresh(credentials.refreshToken)

        return authCredentials
    }
}

// MARK: - Private methods

private extension AuthRepository {

    func handleLogout() throws {
        try credentialsLocalDataSource.delete()
        logOutHandler?()
    }

    func authenticate<T: NetworkConfig>(networkConfig: T) async throws {
        let authCredential: AuthCredentials = try await networkService.request(config: networkConfig, authorized: false)
        try credentialsLocalDataSource.save(authCredential)
    }

    func refresh(_ token: String) async throws -> AuthCredentials {
        let refreshTokenDto = RefreshTokenDTO(refreshToken: token)
        let networkConfig = AuthNetworkConfig.refresh(refreshTokenDto)

        let authCredentials: AuthCredentials = try await networkService.request(config: networkConfig, authorized: true)
        try credentialsLocalDataSource.update(authCredentials)

        return authCredentials
    }
}
