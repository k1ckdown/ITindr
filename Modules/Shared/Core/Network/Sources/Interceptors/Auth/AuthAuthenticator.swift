//
//  AuthAuthenticator.swift
//  Network
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Alamofire
import Foundation

public protocol AuthInterceptorDelegate: AnyObject {
    func handleTokenExpiration() throws
    func refresh() async throws -> AuthCredentials
    func retrieveCredentials() throws -> AuthCredentials
}

public final class AuthInterceptor: RequestInterceptor {

    public weak var delegate: AuthInterceptorDelegate?

    public init() {}

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        Task {
            do {
                let isRefreshRequest = isRefreshRequest(urlRequest)
                guard let accessToken = try await getAccessToken(isRefreshing: isRefreshRequest) else {
                    return completion(.success(urlRequest))
                }

                let request = addAuthorization(to: urlRequest, token: accessToken)
                completion(.success(request))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private methods

private extension AuthInterceptor {

    func isRefreshRequest(_ urlRequest: URLRequest) -> Bool {
        guard let url = urlRequest.url else { return false }
        return url.absoluteString.hasSuffix(Constants.refreshPath)
    }

    func addAuthorization(to urlRequest: URLRequest, token: String) -> URLRequest {
        var request = urlRequest
        request.headers.add(.authorization(bearerToken: token))

        return request
    }

    func getAccessToken(isRefreshing: Bool) async throws -> String? {
        guard let delegate else { return nil }
        let credentials = try delegate.retrieveCredentials()
        
        if isRefreshing || .now < credentials.accessTokenExpiredAt {
            return credentials.accessToken
        }

        if .now < credentials.refreshTokenExpiredAt {
            let refreshedCredentials = try await delegate.refresh()
            return refreshedCredentials.accessToken
        }

        try delegate.handleTokenExpiration()
        throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: HTTPStatusCode.unauthorized.rawValue))
    }
}

// MARK: - Constants

private extension AuthInterceptor {

    enum Constants {
        static let refreshPath = "auth/refresh"
    }
}
