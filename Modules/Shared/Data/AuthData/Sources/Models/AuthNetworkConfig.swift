//
//  AuthNetworkConfig.swift
//  AuthData
//
//  Created by Ivan Semenov on 10.05.2024.
//

import Network

enum AuthNetworkConfig: NetworkConfig {
    case logout
    case refresh(RefreshTokenDTO)
    case register(UserRegisterDTO)
    case login(LoginCredentialsDTO)

    var path: String {
        "http://itindr.mcenter.pro:8092/api/mobile/v1/auth/"
    }

    var endpoint: String {
        switch self {
        case .logout: "logout"
        case .refresh: "refresh"
        case .register: "register"
        case .login: "login"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .logout: .delete
        case .refresh: .post
        case .register: .post
        case .login: .post
        }
    }

    var parameters: Encodable? {
        switch self {
        case .logout: nil
        case .refresh(let refreshTokenDTO): refreshTokenDTO
        case .register(let userRegisterDTO): userRegisterDTO
        case .login(let loginCredentialsDTO): loginCredentialsDTO
        }
    }
}
