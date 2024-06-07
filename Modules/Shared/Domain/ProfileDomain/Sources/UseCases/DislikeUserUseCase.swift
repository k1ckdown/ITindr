//
//  DislikeUserUseCase.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

public final class DislikeUserUseCase {

    private let userRepository: UserRepositoryProtocol

    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

    public func execute(userId: String) async throws {
        try await userRepository.dislike(userId: userId)
    }
}
