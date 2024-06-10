//
//  ProfileLocalDataSource.swift
//  ProfileData
//
//  Created by Ivan Semenov on 10.06.2024.
//

import CoreData
import UserCoreData
import ProfileDomain

final class ProfileLocalDataSource {
    private let coreDataStack = CoreDataStack.shared
}

// MARK: - Public methods

extension ProfileLocalDataSource {

    func fetchProfile() async throws -> UserProfile? {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    let cdProfile = try self.fetchCurrentUser(in: context)
                    continuation.resume(returning: cdProfile?.toDomain())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func deleteAvatar() async throws {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    if let cdProfile = try self.fetchCurrentUser(in: context) {
                        cdProfile.avatarData = nil
                        cdProfile.avatarUrl = nil
                        try context.save()
                    }
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func updateAvatar(_ data: Data) async throws {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    if let cdProfile = try self.fetchCurrentUser(in: context) {
                        cdProfile.avatarData = data
                        try context.save()
                    }
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func saveProfile(_ profile: UserProfile) async throws {
        try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    if let existsProfile = try self.fetchCurrentUser(in: context) {
                        if existsProfile.id != profile.id {
                            existsProfile.avatarData = nil
                            existsProfile.isCurrent = false
                        } else {
                            existsProfile.name = profile.name
                            existsProfile.avatarUrl = profile.avatarUrl
                            existsProfile.aboutMyself = profile.aboutMyself
                            existsProfile.topics = NSSet(array: profile.topics.map { TopicCD($0, context: context) })
                        }
                    } else {
                        let cdProfile = UserProfileCD(profile, context: context)
                        cdProfile.isCurrent = true
                    }

                    try context.save()
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - Private methods

private extension ProfileLocalDataSource {

    func fetchCurrentUser(in context: NSManagedObjectContext) throws -> UserProfileCD? {
        let fetchRequest = UserProfileCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Constants.isCurrentPredicate, NSNumber(value: true))

        let user = try context.fetch(fetchRequest).first
        return user
    }
}

// MARK: - Constants

private extension ProfileLocalDataSource {

    enum Constants {
        static let isCurrentPredicate = "isCurrent = %@"
    }
}
