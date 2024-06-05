//
//  UserRepository.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import CommonDomain
import ProfileDomain

final class UserRepository {

    private let remoteDataSource: UserRemoteDataSource

    init(remoteDataSource: UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - UserRepositoryProtocol

extension UserRepository: UserRepositoryProtocol {

    func dislike(userId: String) async throws {
        try await remoteDataSource.dislike(userId: userId)
    }

    func like(userId: String) async throws -> Bool {
        try await remoteDataSource.like(userId: userId)
    }

    func getUsersFeed() async throws -> [UserProfile] {
        let userDtos = try await remoteDataSource.fetchUsersFeed()
        return userDtos.toDomain()
    }

    func getAllUsers(pagination: Pagination) async throws -> [UserProfile] {
        let userDtos = try await remoteDataSource.fetchUsersFeed()
        return userDtos.toDomain()
    }
}
