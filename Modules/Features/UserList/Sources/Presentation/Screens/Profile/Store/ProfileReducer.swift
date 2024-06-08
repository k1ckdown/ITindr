//
//  ProfileReducer.swift
//  UserList
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UDFKit
import ProfileDomain

struct ProfileReducer: Reducer {
    
    func reduce(state: inout ProfileState, intent: ProfileIntent) {
        switch intent {
        case .onAppear:
            state = .loading
        case .likeTapped:
            break
        case .rejectTapped:
            break
        case .dataLoaded(let user):
            state = .loaded(mapToViewModel(user: user))
        }
    }
    
    private func mapToViewModel(user: UserProfile) -> ProfileState.User {
        ProfileState.User(
            username: user.name,
            avatarUrl: user.avatarUrl,
            aboutMyself: user.aboutMyself,
            topics: user.topics.map { .init(id: $0.id, title: $0.title) }
        )
    }
}
