//
//  UserRepository.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import CommonDomain
import ProfileDomain

final class UserRepository {

    private let localDataSource: UserLocalDataSource
    private let remoteDataSource: UserRemoteDataSource

    init(localDataSource: UserLocalDataSource, remoteDataSource: UserRemoteDataSource) {
        self.localDataSource = localDataSource
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
        let userDtos = try await remoteDataSource.fetchAllUsers(pagination: pagination)

        let localUsers = try await localDataSource.fetchAllUsers()
        print("Local count: \(localUsers.count)")

        return userDtos.toDomain()
    }
}
