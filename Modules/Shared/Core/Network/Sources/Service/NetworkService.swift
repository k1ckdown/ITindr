//
//  NetworkService.swift
//
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Alamofire
import Foundation

public protocol NetworkServiceProtocol: AnyObject {
    func request(config: NetworkConfig, authorized: Bool) async throws
    func multipartRequest(config: MultipartNetworkConfig, authorized: Bool) async throws
    func request<T: Decodable>(config: NetworkConfig, authorized: Bool) async throws -> T
    func multipartRequest<T: Decodable>(config: MultipartNetworkConfig, authorized: Bool) async throws -> T
}

public final class NetworkService {
    
    private let authInterceptor: AuthInterceptor
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    public init(authInterceptor: AuthInterceptor) {
        self.authInterceptor = authInterceptor
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    
    public func request(config: NetworkConfig, authorized: Bool) async throws {
        let request = try buildDataRequest(config: config, authorized: authorized)
        try await makeRequest(request, authorized: authorized)
    }

    public func multipartRequest(config: MultipartNetworkConfig, authorized: Bool) async throws {
        let request = buildUploadRequest(config: config, authorized: authorized)
        try await makeRequest(request, authorized: authorized)
    }

    public func request<T: Decodable>(config: NetworkConfig, authorized: Bool) async throws -> T {
        let request = try buildDataRequest(config: config, authorized: authorized)
        let data = try await makeRequest(request, authorized: authorized)
        let value = try jsonDecoder.decode(T.self, from: data)
        
        return value
    }

    public func multipartRequest<T: Decodable>(config: MultipartNetworkConfig, authorized: Bool) async throws -> T {
        let request = buildUploadRequest(config: config, authorized: authorized)
        let data = try await makeRequest(request, authorized: authorized)
        let value = try jsonDecoder.decode(T.self, from: data)

        return value
    }
}

// MARK: - Private methods

private extension NetworkService {

    @discardableResult
    func makeRequest(_ request: DataRequest, authorized: Bool) async throws -> Data {
        let dataTask = request.serializingData()
        
        do {
            return try await dataTask.value
        } catch {
            throw resolveError(error, data: request.data)
        }
    }
    
    func buildUploadRequest(config: MultipartNetworkConfig, authorized: Bool) -> UploadRequest {
        let interceptor = authorized ? authInterceptor : nil
        
        return AF.upload(
            multipartFormData: { formData in
                config.parameters.forEach { key, data in
                    formData.append(data, withName: key)
                }

                config.files.forEach { key, file in
                    formData.append(file.data, withName: key, fileName: file.fileName)
                }
            },
            to: config.absolutePath,
            interceptor: interceptor
        )
    }
    
    func buildDataRequest(config: NetworkConfig, authorized: Bool) throws -> DataRequest {
        let parameters = try encodeToDictionary(config.parameters)
        let interceptor = authorized ? authInterceptor : nil
        let encoding = getEncoding(by: config.method)
        
        let request = AF.request(
            config.absolutePath,
            method: config.method,
            parameters: parameters,
            encoding: encoding,
            interceptor: interceptor
        ).validate()
        
        return request
    }
    
    func getEncoding(by method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .put, .post, .patch:
            JSONEncoding.default
        default:
            URLEncoding.default
        }
    }
    
    func encodeToDictionary(_ value: Encodable?) throws -> [String: Any]? {
        guard let value else { return nil }
        
        let data = try jsonEncoder.encode(value)
        let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        return dictionary
    }
    
    func resolveSessionTaskError(_ error: Error) -> NetworkError {
        let nsError = error as NSError
        let code = URLError.Code(rawValue: nsError.code)
        
        return switch code {
        case .timedOut: .timedOut
        case .notConnectedToInternet: .notConnected
        case .userAuthenticationRequired: .unauthorized
        default: .unknown(error)
        }
    }
    
    func resolveError(_ error: Error, data: Data?) -> NetworkError {
        guard let alamofireError = error as? AFError else { return .unknown(error) }
        
        switch alamofireError {
        case .sessionTaskFailed(let error):
            return resolveSessionTaskError(error)
            
        case .responseValidationFailed(.unacceptableStatusCode(let code)):
            guard let httpStatusCode = HTTPStatusCode(rawValue: code) else { return .unknown(alamofireError) }
            return .requestFailed(httpStatusCode, data)
            
        default:
            return .unknown(error)
        }
    }
}
