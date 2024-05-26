//
//  UpdateUserProfileUseCase.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 26.05.2024.
//

public final class UpdateUserProfileUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    public func execute(_ profile: UserProfileEdit) async throws {
        try await profileRepository.updateProfile(profile)
    }
}
