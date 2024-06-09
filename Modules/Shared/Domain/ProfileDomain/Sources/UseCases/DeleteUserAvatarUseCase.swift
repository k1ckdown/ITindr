//
//  DeleteUserAvatarUseCase.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 09.06.2024.
//

public final class DeleteUserAvatarUseCase {

    private let profileRepository: ProfileRepositoryProtocol

    public init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }

    public func execute() async throws {
        try await profileRepository.deleteAvatar()
    }
}
