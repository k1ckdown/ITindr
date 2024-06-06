//
//  UserListViewModel.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import Foundation

final class UserListViewModel {

    var isLoading: ((Bool) -> Void)?
    var refreshUserList: (() -> Void)?

    private(set) var userCellViewModels: [UserCellViewModel] = []
}

// MARK: - Public methods

extension UserListViewModel {

    func userTapped(at index: Int) {
        print(index)
    }

    func viewWillAppear() {
        isLoading?(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading?(false)
            self.userCellViewModels = UserCellViewModel.mock
            self.refreshUserList?()
        }
    }
}
