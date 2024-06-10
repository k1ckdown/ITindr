//
//  UserListReducer.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UDFKit
import CommonDomain
import ProfileDomain

typealias UserListStore = StoreOf<UserListReducer>

struct UserListReducer: Reducer {

    func reduce(state: inout UserListState, intent: UserListIntent) {
        switch intent {
        case .loadMore: break
        case .onAppear:
            handleOnAppear(&state)
        case .loadMoreStarted:
            handleLoadMoreStart(&state)
        case .userTapped(let index):
            handleUserTap(&state, index: index)
        case .loadFailed(let error):
            state = .failed(error)
        case .dataLoaded(let data, let pagination):
            handleDataLoad(&state, data: data, pagination: pagination)
        }
    }
}

// MARK: - Private methods

private extension UserListReducer {

    func handleOnAppear(_ state: inout State) {
        guard case .idle = state else { return }
        state = .loading
    }

    func handleUserTap(_ state: inout State, index: Int) {
        guard case .loaded(var viewData) = state else { return }

        viewData.selectedUserIndex = index
        state = .loaded(viewData)
    }

    func handleLoadMoreStart(_ state: inout UserListState) {
        guard case .loaded(var viewData) = state else { return }

        viewData.isMoreLoading = true
        state = .loaded(viewData)
    }

    func handleDataLoad(_ state: inout State, data: [UserProfile], pagination: Pagination) {
        let nextPage = pagination.nextPage
        let userViewModels = data.map { mapToViewModel(user: $0) }

        switch state {
        case .loading:
            let viewData = UserListState.ViewData(pagination: nextPage, users: userViewModels)
            state = .loaded(viewData)
        case .loaded(var viewData):
            viewData.pagination = nextPage
            viewData.isMoreLoading = false
            viewData.users.append(contentsOf: userViewModels)
            state = .loaded(viewData)
        default: break
        }
    }

    func mapToViewModel(user: UserProfile) -> UserCellViewModel {
        UserCellViewModel(name: user.name, avatarUrl: user.avatarUrl)
    }
}
