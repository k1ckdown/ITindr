//
//  ProfileRepository.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import ProfileDomain
import Foundation

final class ProfileRepository {

    private let remoteDataSource: ProfileRemoteDataSource

    init(remoteDataSource: ProfileRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - ProfileRepositoryProtocol

extension ProfileRepository: ProfileRepositoryProtocol {

    func deleteAvatar() async throws {
        try await remoteDataSource.deleteAvatar()
    }

    func saveAvatar(data: Data, fileName: String) async throws {
        try await remoteDataSource.uploadAvatar(data: data, fileName: fileName)
    }

    func getProfile() async throws -> UserProfile {
        let profileDto = try await remoteDataSource.fetchProfile()
        return profileDto.toDomain()
    }

    func updateProfile(_ profile: UserProfileEdit) async throws {
        let profileDto = profile.toDto()
        try await remoteDataSource.updateProfile(profileDto)
    }
}
