//
//  GetUsersFeedUseCase.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

final class GetUsersFeedUseCase {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute() async throws -> [UserProfile] {
        try await userRepository.getUsersFeed()
    }
}
