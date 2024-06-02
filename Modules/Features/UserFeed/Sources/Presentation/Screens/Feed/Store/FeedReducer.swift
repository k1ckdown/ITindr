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
            state = .loading
        case .loadFailed(let message):
            state = .failed(message)
        case .userLoaded(let user):
            guard let user else { return state = .loaded(nil) }
            state = .loaded(mapToViewModel(user: user))
        }
    }

    private func mapToViewModel(user: UserProfile) -> FeedState.User {
        FeedState.User (
            username: user.name,
            avatarUrl: user.avatarUrl,
            aboutMyself: user.aboutMyself,
            topics: user.topics.map(\.title)
        )
    }
}
