//
//  MultipartNetworkConfig.swift
//  Network
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Foundation

public protocol MultipartNetworkConfig: BaseNetworkConfig {
    var parameters: [String: Data] { get }
    var files: [String: [(data: Data, fileName: String)]] { get }
}
