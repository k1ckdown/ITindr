//
//  ProfileReducer.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UDFKit
import ProfileDomain

struct ProfileReducer: Reducer {

    func reduce(state: inout ProfileState, intent: ProfileIntent) {
        switch intent {
        case .editTapped: break
        case .onAppear:
            state = .loading
        case .dataLoadFailed(let error):
            state = .failed(error)
        case .dataLoaded(let profile):
            state = .loaded(getViewData(from: profile))
        }
    }

    private func getViewData(from profile: UserProfile) -> ProfileState.ViewData {
        ProfileState.ViewData(
            username: profile.name,
            avatarUrl: profile.avatarUrl,
            avatarData: profile.avatarData,
            aboutMyself: profile.aboutMyself,
            topics: profile.topics.map { .init(id: $0.id, title: $0.title) }
        )
    }
}
