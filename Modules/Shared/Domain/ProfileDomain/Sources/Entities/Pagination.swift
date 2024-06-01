//
//  Pagination.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 02.06.2024.
//

public struct Pagination: Equatable {
    public let page: Int
    public let count: Int

    public init(page: Int, count: Int = 10) {
        self.page = page
        self.count = count
    }

    public var next: Pagination {
        .init(page: self.page + 1, count: self.count)
    }
}
