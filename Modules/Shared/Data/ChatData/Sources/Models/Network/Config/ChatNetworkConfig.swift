//
//  ChatNetworkConfig.swift
//  ChatData
//
//  Created by Ivan Semenov on 03.06.2024.
//

import Network
import ChatDomain

enum ChatNetworkConfig: NetworkConfig {
    case chatList
    case newChat(userId: String)
    case chatMessages(chatId: String, pagination: Pagination)
    
    var path: String { NetworkConstants.baseUrlString }
    
    var endpoint: String {
        switch self {
        case .chatList, .newChat: ""
        case .chatMessages(let chatId, _): "/\(chatId)/message"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatList: .get
        case .newChat: .post
        case .chatMessages: .get
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .chatList: nil
        case .newChat(let userId): userId
        case .chatMessages(_, let pagination): ["limit": pagination.count, "offset": pagination.page]
        }
    }
}
