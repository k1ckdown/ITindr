//
//  UserLocalDataSource.swift
//  UserData
//
//  Created by Ivan Semenov on 09.06.2024.
//

import UserCoreData
import CommonDomain
import ProfileDomain

final class UserLocalDataSource {
    private let coreDataStack = CoreDataStack.shared
}

// MARK: - Public methods

extension UserLocalDataSource {

    func saveUserList(_ users: [UserProfile]) async throws {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    let _ = users.map { UserProfileCD($0, context: context) }
                    try context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func fetchAllUsers(pagination: Pagination) async throws -> [UserProfile] {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    let fetchRequest = UserProfileCD.fetchRequest()
                    fetchRequest.fetchLimit = pagination.limit
                    fetchRequest.fetchOffset = pagination.offset

                    let cdUsers = try context.fetch(fetchRequest)
                    continuation.resume(returning: cdUsers.map { $0.toDomain() })
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
