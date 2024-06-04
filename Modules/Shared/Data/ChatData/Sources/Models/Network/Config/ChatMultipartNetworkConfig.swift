//
//  ChatMultipartNetworkConfig.swift
//  ChatData
//
//  Created by Ivan Semenov on 05.06.2024.
//

import Network
import Foundation
import ChatDomain

enum ChatMultipartNetworkConfig: MultipartNetworkConfig {
    case sendMessage(MessageSend)

    var path: String { NetworkConstants.baseUrlString }

    var endpoint: String {
        switch self {
        case .sendMessage(let message): "/\(message.chatId)/message"
        }
    }

    var parameters: [String : Data] {
        switch self {
        case .sendMessage(let message):
            guard let textData = message.text.data(using: .utf8) else { return [:] }
            return ["messageText": textData]
        }
    }

    // TODO: Attachments
    var files: [String : (data: Data, fileName: String)] {
        [:]
    }
}
