//
//  UserRepository.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import ProfileDomain

final class UserRepository {

    private let remoteDataSource: UserRemoteDataSource

    init(remoteDataSource: UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - UserRepositoryProtocol

extension UserRepository: UserRepositoryProtocol {

    func like(userId: Int) async throws {
        try await remoteDataSource.like(userId: userId)
    }

    func dislike(userId: Int) async throws {
        try await remoteDataSource.dislike(userId: userId)
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
