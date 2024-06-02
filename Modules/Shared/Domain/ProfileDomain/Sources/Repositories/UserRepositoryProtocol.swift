//
//  UserRepositoryProtocol.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public protocol UserRepositoryProtocol: AnyObject {
    func dislike(userId: String) async throws
    func like(userId: String) async throws -> Bool
    func getUsersFeed() async throws -> [UserProfile]
    func getAllUsers(pagination: Pagination) async throws -> [UserProfile]
}
