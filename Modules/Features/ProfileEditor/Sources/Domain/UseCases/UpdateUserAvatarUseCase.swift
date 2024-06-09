//
//  UpdateUserAvatarUseCase.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 26.05.2024.
//

import CommonDomain
import ProfileDomain

final class UpdateUserAvatarUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    public func execute(_ avatar: Resource) async throws {
        try await profileRepository.saveAvatar(avatar)
    }
}
