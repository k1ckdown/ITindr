//
//  TopicNetworkConfig.swift
//  TopicData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network

enum TopicNetworkConfig: NetworkConfig {
    case list

    var path: String {
        "http://itindr.mcenter.pro:8092/api/mobile/v1/topic"
    }

    var endpoint: String {
        ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .list: .get
        }
    }

    var parameters: Encodable? {
        switch self {
        case .list: nil
        }
    }
}
