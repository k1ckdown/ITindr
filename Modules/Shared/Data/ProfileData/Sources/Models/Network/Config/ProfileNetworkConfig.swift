//
//  ProfileNetworkConfig.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network
import Foundation

enum ProfileNetworkConfig: NetworkConfig {
    case get
    case update(UserProfileEditDTO)
    case deleteAvatar

    var path: String { NetworkConstants.baseUrlString }

    var endpoint: String {
        switch self {
        case .get, .update: ""
        case .deleteAvatar: "avatar"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .get: .get
        case .update: .patch
        case .deleteAvatar: .delete
        }
    }

    var parameters: Encodable? {
        switch self {
        case .get, .deleteAvatar: nil
        case .update(let userProfileEditDTO): userProfileEditDTO
        }
    }
}
