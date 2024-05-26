//
//  UpdateUserAvatarUseCase.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 26.05.2024.
//

import Foundation

public final class UpdateUserAvatarUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    public func execute(_ avatar: Resource) async throws {
        try await profileRepository.saveAvatar(data: avatar.data, fileName: avatar.fileName)
    }
}
