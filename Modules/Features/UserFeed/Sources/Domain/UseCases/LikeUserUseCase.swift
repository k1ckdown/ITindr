//
//  LikeUserUseCase.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

final class LikeUserUseCase {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute(userId: String) async throws -> Bool {
        try await userRepository.like(userId: userId)
    }
}
