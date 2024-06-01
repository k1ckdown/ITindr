//
//  UserRemoteDataSource.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Network

final class UserRemoteDataSource {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Public methods

extension UserRemoteDataSource {

    func like(userId: Int) async throws {
        let config = UserNetworkConfig.like(userId: userId)
        try await networkService.request(config: config, authorized: true)
    }

    func dislike(userId: Int) async throws {
        let config = UserNetworkConfig.dislike(userId: userId)
        try await networkService.request(config: config, authorized: true)
    }

    func fetchUsersFeed() async throws -> [UserProfileDTO] {
        let config = UserNetworkConfig.feed
        return try await networkService.request(config: config, authorized: true)
    }

    func fetchAllUsers(limit: Int, offset: Int) async throws -> [UserProfileDTO] {
        let config = UserNetworkConfig.allUsers(limit: limit, offset: offset)
        return try await networkService.request(config: config, authorized: true)
    }
}
