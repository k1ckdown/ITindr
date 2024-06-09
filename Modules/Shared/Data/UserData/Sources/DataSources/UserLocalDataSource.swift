//
//  UserLocalDataSource.swift
//  UserData
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UserCoreData
import ProfileDomain

final class UserLocalDataSource {
    private let coreDataStack = CoreDataStack.shared
}

// MARK: - Public methods

extension UserLocalDataSource {

    func saveUserList(_ users: [UserProfile]) async throws {
    }

    func updateUserList(_ users: [UserProfile]) async throws {

    }

    func fetchAllUsers() async throws -> [UserProfileCD] {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { content in
                do {
                    let fetchRequest = UserProfileCD.fetchRequest()
                    let cdUsers = try content.fetch(fetchRequest)
                    continuation.resume(returning: cdUsers)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
