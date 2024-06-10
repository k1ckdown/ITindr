//
//  ProfileRepository.swift
//  ProfileData
//
//  Created by Ivan Semenov on 14.05.2024.
//

import CommonDomain
import ProfileDomain

final class ProfileRepository {

    private var profileId: String?
    private let localDataSource: ProfileLocalDataSource
    private let remoteDataSource: ProfileRemoteDataSource

    init(localDataSource: ProfileLocalDataSource, remoteDataSource: ProfileRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

// MARK: - ProfileRepositoryProtocol

extension ProfileRepository: ProfileRepositoryProtocol {

    func getUserId() async throws -> String {
        if let profileId { return profileId }

        let profile = try await getProfile()
        self.profileId = profile.id

        return profile.id
    }

    func deleteAvatar() async throws {
        try await localDataSource.deleteAvatar()
        try await remoteDataSource.deleteAvatar()
    }

    func saveAvatar(_ avatar: Resource) async throws {
        try await localDataSource.updateAvatar(avatar.data)
        try await remoteDataSource.uploadAvatar(avatar)
    }

    func updateProfile(_ profileEdit: UserProfileEdit) async throws {
        let profileEditDto = profileEdit.toDto()
        let profile = try await remoteDataSource.updateProfile(profileEditDto)
        try await localDataSource.saveProfile(profile.toDomain())
    }

    func getProfile() async throws -> UserProfile {
        let profile: UserProfile
        if let localProfile = try await localDataSource.fetchProfile() {
            profile = localProfile
        } else {
            let remoteProfile = try await remoteDataSource.fetchProfile()
            profile = remoteProfile.toDomain()
            Task { try await localDataSource.saveProfile(profile) }
        }

        profileId = profile.id
        return profile
    }
}
