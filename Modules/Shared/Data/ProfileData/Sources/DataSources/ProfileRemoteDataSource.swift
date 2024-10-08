//
//  ProfileRemoteDataSource.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import Network
import CommonDomain

final class ProfileRemoteDataSource {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - Public methods

extension ProfileRemoteDataSource {

    func fetchProfile() async throws -> UserProfileDTO {
        let networkConfig = ProfileNetworkConfig.get
        return try await networkService.request(config: networkConfig, authorized: true)
    }

    func updateProfile(_ profile: UserProfileEditDTO) async throws -> UserProfileDTO {
        let networkConfig = ProfileNetworkConfig.update(profile)
        return try await networkService.request(config: networkConfig, authorized: true)
    }

    func deleteAvatar() async throws {
        let networkConfig = ProfileNetworkConfig.deleteAvatar
        try await networkService.request(config: networkConfig, authorized: true)
    }

    func uploadAvatar(_ resource: Resource) async throws {
        let networkConfig = ProfileMultipartNetworkConfig.uploadAvatar(resource)
        try await networkService.multipartRequest(config: networkConfig, authorized: true)
    }
}
