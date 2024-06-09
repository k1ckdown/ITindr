//
//  GetUserProfileUseCase.swift
//  Profile
//
//  Created by Ivan Semenov on 09.06.2024.
//

import ProfileDomain

final class GetUserProfileUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    func execute() async throws -> UserProfile {
        try await profileRepository.getProfile()
    }
}
