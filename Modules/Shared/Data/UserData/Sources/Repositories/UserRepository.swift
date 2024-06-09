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
        let users: [UserProfile]
        let localUsers = try await localDataSource.fetchAllUsers(pagination: pagination)

        if localUsers.isEmpty {
            users = try await refreshUsers(pagination: pagination)
        } else {
            users = localUsers
            Task { try await refreshUsers(pagination: pagination) }
        }

        return users
    }
}

// MARK: - Private methods

private extension UserRepository {

    func refreshUsers(pagination: Pagination) async throws -> [UserProfile] {
        let userDtos = try await remoteDataSource.fetchAllUsers(pagination: pagination)
        let users = userDtos.toDomain()
        try await localDataSource.saveUserList(users)
        return users
    }
}
