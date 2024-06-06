//
//  GetUserListUseCase.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import CommonDomain
import ProfileDomain

final class GetUserListUseCase {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute(pagination: Pagination) async throws -> [UserProfile] {
        try await userRepository.getAllUsers(pagination: pagination)
    }
}
