//
//  UseCaseFactory.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

final class UseCaseFactory {

    private let userRepository: UserRepositoryProtocol

    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
}

// MARK: - Public methods

extension UseCaseFactory {

    func makeLikeUserUseCase() -> LikeUserUseCase {
        LikeUserUseCase(userRepository: userRepository)
    }

    func makeDislikeUserUseCase() -> DislikeUserUseCase {
        DislikeUserUseCase(userRepository: userRepository)
    }

    func makeGetUsersFeedUseCase() -> GetUsersFeedUseCase {
        GetUsersFeedUseCase(userRepository: userRepository)
    }
}
