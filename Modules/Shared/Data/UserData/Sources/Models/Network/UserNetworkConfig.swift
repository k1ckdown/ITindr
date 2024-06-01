//
//  UserNetworkConfig.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Network

enum UserNetworkConfig: NetworkConfig {
    case feed
    case like(userId: Int)
    case dislike(userId: Int)
    case allUsers(limit: Int, offset: Int)

    var method: HTTPMethod {
        switch self {
        case .feed, .allUsers: .get
        case .like, .dislike: .post
        }
    }

    var parameters: Encodable? {
        switch self {
        case .feed, .like, .dislike: nil
        case .allUsers(let limit, let offset): ["limit": limit, "offset": offset]
        }
    }
    
    var path: String {
        "http://itindr.mcenter.pro:8092/api/mobile/v1/user"
    }

    var endpoint: String {
        switch self {
        case .allUsers: ""
        case .feed: "/feed"
        case .like(let userId): "/\(userId)/like"
        case .dislike(let userId): "/\(userId)/dislike"
        }
    }
}
