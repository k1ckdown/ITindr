//
//  UseCaseFactory.swift
//  UserList
//
//  Created by Ivan Semenov on 08.06.2024.
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

    func makeGetUserListUseCase() -> GetUserListUseCase {
        GetUserListUseCase(userRepository: userRepository)
    }
}
