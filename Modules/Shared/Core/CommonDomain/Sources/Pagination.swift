//
//  Pagination.swift
//  CommonDomain
//
//  Created by Ivan Semenov on 05.06.2024.
//

public struct Pagination: Equatable {
    public let offset: Int
    public let limit: Int

    public static var firstPage = Pagination(offset: 0)
    public var nextPage: Pagination {
        .init(offset: offset + limit, limit: limit)
    }

    public init(offset: Int, limit: Int = 20) {
        self.offset = offset
        self.limit = limit
    }
}
