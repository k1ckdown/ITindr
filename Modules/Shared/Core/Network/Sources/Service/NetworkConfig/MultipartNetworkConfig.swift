//
//  MultipartNetworkConfig.swift
//  Network
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Foundation

public protocol MultipartNetworkConfig: BaseNetworkConfig {
    var key: String { get }
    var data: Data { get }
    var fileName: String { get }
}
