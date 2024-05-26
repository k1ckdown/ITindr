//
//  ProfileMultipartNetworkConfig.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network
import Foundation

enum ProfileMultipartNetworkConfig: MultipartNetworkConfig {
    case uploadAvatar(data: Data, fileName: String)
    
    var path: String { NetworkConstants.baseUrlString }
    
    var endpoint: String {
        switch self {
        case .uploadAvatar:
            "/avatar"
        }
    }
    
    var key: String {
        switch self {
        case .uploadAvatar: "avatar"
        }
    }
    
    var data: Data {
        switch self {
        case .uploadAvatar(let data, _): data
        }
    }
    
    var fileName: String {
        switch self {
        case .uploadAvatar(_, let fileName): fileName
        }
    }
}
