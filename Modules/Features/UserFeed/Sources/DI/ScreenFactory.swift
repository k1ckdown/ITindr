//
//  ScreenFactory.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit

final class ScreenFactory {

    private let useCaseFactory: UseCaseFactory

    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
}

// MARK: - Public methods

@MainActor
extension ScreenFactory {

    func makeFeedScreen(middlewareDelegate: FeedMiddlewareDelegate?) -> FeedScreen {
        let reducer = FeedReducer()
        let middleware = FeedMiddleware(
            likeUserUseCase: useCaseFactory.makeLikeUserUseCase(),
            dislikeUserUseCase: useCaseFactory.makeDislikeUserUseCase(),
            getUsersFeedUseCase: useCaseFactory.makeGetUsersFeedUseCase(),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: FeedState.idle, reducer: reducer, middleware: middleware)
        return FeedScreen(store: store)
    }
}
