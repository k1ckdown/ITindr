//
//  BaseNetworkConfig.swift
//  Network
//
//  Created by Ivan Semenov on 14.05.2024.
//

public protocol BaseNetworkConfig {
    var path: String { get }
    var endpoint: String { get }
}

extension BaseNetworkConfig {
    var absolutePath: String { path + endpoint }
}
