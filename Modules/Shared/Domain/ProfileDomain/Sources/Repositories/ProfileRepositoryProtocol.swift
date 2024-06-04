//
//  ProfileRepositoryProtocol.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 13.05.2024.
//

import Foundation

public protocol ProfileRepositoryProtocol: AnyObject {
    func deleteAvatar() async throws
    func getUserId() async throws -> String
    func getProfile() async throws -> UserProfile
    func saveAvatar(data: Data, fileName: String) async throws
    func updateProfile(_ profile: UserProfileEdit) async throws
}
