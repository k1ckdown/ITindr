//
//  ProfileRepository.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import CommonDomain
import ProfileDomain

final class ProfileRepository {

    private var profile: UserProfile?
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

    func saveAvatar(_ avatar: Resource) async throws {
        try await remoteDataSource.uploadAvatar(avatar)
    }

    func getProfile() async throws -> UserProfile {
        let profileDto = try await remoteDataSource.fetchProfile()
        return profileDto.toDomain()
    }

    func updateProfile(_ profile: UserProfileEdit) async throws {
        let profileDto = profile.toDto()
        try await remoteDataSource.updateProfile(profileDto)
    }

    func getUserId() async throws -> String {
        if let profile { return profile.id }

        let profileDto = try await remoteDataSource.fetchProfile()
        profile = profileDto.toDomain()

        return profileDto.userId
    }
}
