//
//  ScreenFactory.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import ProfileDomain

final class ScreenFactory {

    private let useCaseFactory: UseCaseFactory

    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
}

// MARK: - Public methods

@MainActor
extension ScreenFactory {

    func makeProfileScreen(user: UserProfile) -> ProfileScreen {
        let reducer = ProfileReducer()
        let middleware = ProfileMiddleware()
        let initialState = ProfileState(
            username: user.name,
            avatarUrl: user.avatarUrl,
            aboutMyself: user.aboutMyself,
            topics: user.topics.map { .init(id: $0.id, title: $0.title) }
        )

        let store = Store(initialState: initialState, reducer: reducer, middleware: middleware)
        return ProfileScreen(store: store)
    }

    func makeFeedScreen(middlewareDelegate: FeedMiddlewareDelegate?) -> FeedScreen {
        let reducer = FeedReducer()
        let middleware = FeedMiddleware(
            likeUserUseCase: useCaseFactory.makeLikeUserUseCase(),
            dislikeUserUseCase: useCaseFactory.makeDislikeUserUseCase(),
            getUsersFeedUseCase: useCaseFactory.makeGetUsersFeedUseCase(),
            delegate: middlewareDelegate
        )

        let store = Store(initialState: FeedState.idle, reducer: reducer, middleware: middleware)
        let cancelMatchHandler: ((UserProfile?) -> Void) = { [weak store] in store?.dispatch(.userSelected($0)) }

        middleware.cancelMatchHandler = cancelMatchHandler
        return FeedScreen(store: store)
    }
}
