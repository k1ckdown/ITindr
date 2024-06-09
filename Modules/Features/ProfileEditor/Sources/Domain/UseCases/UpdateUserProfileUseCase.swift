//
//  UpdateUserProfileUseCase.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 26.05.2024.
//

import ProfileDomain

final class UpdateUserProfileUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    func execute(_ profile: UserProfileEdit) async throws {
        try await profileRepository.updateProfile(profile)
    }
}
