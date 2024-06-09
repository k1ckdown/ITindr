//
//  DeleteUserAvatarUseCase.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 09.06.2024.
//

import ProfileDomain

final class DeleteUserAvatarUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    func execute() async throws {
        try await profileRepository.deleteAvatar()
    }
}
