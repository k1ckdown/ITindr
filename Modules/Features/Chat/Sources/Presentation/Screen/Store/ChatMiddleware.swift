//
//  ChatMiddleware.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import UDFKit
import Navigation

protocol ChatMiddlewareDelegate: AnyObject, Sendable, ErrorPresentable {}

final class ChatMiddleware: Middleware {
    
    private weak var delegate: ChatMiddlewareDelegate?
    
    init(delegate: ChatMiddlewareDelegate?) {
        self.delegate = delegate
    }
    
    func handle(state: ChatState, intent: ChatIntent) async -> ChatIntent? {
        switch intent {
        case .dataLoaded, .loadFailed: break
        case .onAppear:
            return getMessages()
        }
        
        return nil
    }
}

// MARK: - Private methods

private extension ChatMiddleware {
    
    func getMessages() -> ChatIntent {
        return .dataLoaded(MessageCellViewModel.mock)
    }
}
