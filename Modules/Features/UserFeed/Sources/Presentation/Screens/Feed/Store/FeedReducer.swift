//
//  FeedReducer.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UDFKit
import ProfileDomain

struct FeedReducer: Reducer {

    func reduce(state: inout FeedState, intent: FeedIntent) {
        switch intent {
        case .likeTapped, .rejectTapped, .avatarTapped: break
        case .onAppear:
            guard case .idle = state else { return }
            state = .loading
        case .usersMatched:
            guard case .loaded(var user) = state else { return }
            user?.isMutual = true
            state = .loaded(user)
        case .loadFailed(let message):
            state = .failed(message)
        case .userSelected(let user):
            guard let user else { return state = .loaded(nil) }
            state = .loaded(mapToViewModel(user: user))
        }
    }

    private func mapToViewModel(user: UserProfile) -> FeedState.User {
        FeedState.User (
            username: user.name,
            avatarUrl: user.avatarUrl,
            aboutMyself: user.aboutMyself,
            topics: user.topics.map { .init(id: $0.id, title: $0.title) }
        )
    }
}
