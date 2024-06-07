//
//  ScreenFactory.swift
//  UserList
//
//  Created by Ivan Semenov on 08.06.2024.
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

extension ScreenFactory {
    
    func makeUserListScreen(middlewareDelegate: UserListMiddlewareDelegate) -> UserListViewController {
        let reducer = UserListReducer()
        let middleware = UserListMiddleware(
            getUserListUseCase: useCaseFactory.makeGetUserListUseCase(),
            delegate: middlewareDelegate
        )
        
        let store = Store(initialState: .idle, reducer: reducer, middleware: middleware)
        return UserListViewController(store: store)
    }
    
    func makeProfileScreen(profile: UserProfile, middlewareDelegate: ProfileMiddlewareDelegate) -> ProfileScreen {
        let reducer = ProfileReducer()
        let middleware = ProfileMiddleware(
            profile: profile,
            likeUserUseCase: useCaseFactory.makeLikeUserUseCase(),
            dislikeUserUseCase: useCaseFactory.makeDislikeUserUseCase(),
            delegate: middlewareDelegate
        )
        
        let store = Store(initialState: .idle, reducer: reducer, middleware: middleware)
        return ProfileScreen(store: store)
    }
}
