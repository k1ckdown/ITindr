//
//  UserListState.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import CommonDomain
import ProfileDomain

enum UserListState: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded(ViewData)

    struct ViewData: Equatable {
        var isMoreLoading = false
        var pagination: Pagination
        var selectedUserIndex: Int?
        var users: [UserCellViewModel]
    }
}

enum UserListIntent: Equatable {
    case onAppear
    case loadMore
    case loadMoreStarted
    case userTapped(Int)
    case loadFailed(String)
    case dataLoaded([UserProfile], Pagination)
}
