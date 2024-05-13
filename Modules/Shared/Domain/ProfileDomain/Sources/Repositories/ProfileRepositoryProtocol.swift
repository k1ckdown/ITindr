//
//  ProfileRepositoryProtocol.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

import Foundation

public protocol ProfileRepositoryProtocol: AnyObject {
    func deleteAvatar() async throws
    func updateAvatar(_ data: Data) async throws
    func getProfile() async throws -> UserProfile
    func updateProfile(_ profile: UserProfileEdit) async throws
}
