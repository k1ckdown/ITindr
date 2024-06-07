//
//  LikeUserUseCase.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

public final class LikeUserUseCase {

    private let userRepository: UserRepositoryProtocol

    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    public func execute(userId: String) async throws -> Bool {
        try await userRepository.like(userId: userId)
    }
}
