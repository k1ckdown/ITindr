//
//  ProfileRepositoryProtocol.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

import CommonDomain

public protocol ProfileRepositoryProtocol: AnyObject {
    func deleteAvatar() async throws
    func getUserId() async throws -> String
    func getProfile() async throws -> UserProfile
    func saveAvatar(_ avatar: Resource) async throws
    func updateProfile(_ profile: UserProfileEdit) async throws
}
