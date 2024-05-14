//
//  NetworkConfig.swift
//
//
//  Created by Ivan Semenov on 09.05.2024.
//

import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod

public protocol NetworkConfig: BaseNetworkConfig {
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
}
