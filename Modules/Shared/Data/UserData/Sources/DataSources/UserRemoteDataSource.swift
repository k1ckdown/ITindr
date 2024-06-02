//
//  UserRemoteDataSource.swift
//  UserData
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Network
import ProfileDomain

final class UserRemoteDataSource {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Public methods

extension UserRemoteDataSource {

    func dislike(userId: String) async throws {
        let config = UserNetworkConfig.dislike(userId: userId)
        try await networkService.request(config: config, authorized: true)
    }

    func like(userId: String) async throws -> Bool {
        let config = UserNetworkConfig.like(userId: userId)
        let response: UserLikeResponseDTO = try await networkService.request(config: config, authorized: true)

        return response.isMutual
    }

    func fetchUsersFeed() async throws -> [UserProfileDTO] {
        let config = UserNetworkConfig.feed
        return try await networkService.request(config: config, authorized: true)
    }

    func fetchAllUsers(pagination: Pagination) async throws -> [UserProfileDTO] {
        let config = UserNetworkConfig.allUsers(limit: pagination.count, offset: pagination.page)
        return try await networkService.request(config: config, authorized: true)
    }
}
