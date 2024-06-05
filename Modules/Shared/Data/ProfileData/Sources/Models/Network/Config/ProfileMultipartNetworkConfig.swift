//
//  ProfileMultipartNetworkConfig.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network
import Foundation
import CommonDomain

enum ProfileMultipartNetworkConfig: MultipartNetworkConfig {
    case uploadAvatar(Resource)

    var path: String { NetworkConstants.baseUrlString }

    var endpoint: String {
        switch self {
        case .uploadAvatar:
            "/avatar"
        }
    }

    var parameters: [String: Data] { [:] }

    var files: [String: (data: Data, fileName: String)] {
        switch self {
        case .uploadAvatar(let avatar):
            ["avatar": (avatar.data, avatar.fileName)]
        }
    }
}
