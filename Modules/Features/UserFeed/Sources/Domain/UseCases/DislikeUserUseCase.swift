//
//  DislikeUserUseCase.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

final class DislikeUserUseCase {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    func execute(userId: String) async throws {
        try await userRepository.dislike(userId: userId)
    }
}
