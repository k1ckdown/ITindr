//
//  NetworkError.swift
//
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Foundation

public enum NetworkError: Error {
    case timedOut
    case invalidUrl
    case unauthorized
    case notConnected
    case unknown(Error)
    case invalidResponse
    case requestFailed(HTTPStatusCode, Data?)
}
