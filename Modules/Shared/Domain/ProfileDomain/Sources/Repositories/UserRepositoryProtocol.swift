//
//  UserRepositoryProtocol.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public protocol UserRepositoryProtocol: AnyObject {
    func like(userId: Int) async throws
    func dislike(userId: Int) async throws
    func getUsersFeed() async throws -> [UserProfile]
    func getAllUsers(pagination: Pagination) async throws -> [UserProfile]
}
