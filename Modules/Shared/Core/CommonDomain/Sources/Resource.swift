//
//  Resource.swift
//  CommonDomain
//
//  Created by Ivan Semenov on 05.06.2024.
//

import Foundation

public struct Resource: Equatable {
    public let data: Data
    public let fileName: String

    public init(data: Data, fileName: String) {
        self.data = data
        self.fileName = fileName
    }
}
