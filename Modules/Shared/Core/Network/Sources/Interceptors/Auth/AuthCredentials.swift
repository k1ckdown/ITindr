//
//  AuthCredentials.swift
//  Network
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Foundation

public struct AuthCredentials: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let accessTokenExpiredAt: Date
    public let refreshTokenExpiredAt: Date
}
