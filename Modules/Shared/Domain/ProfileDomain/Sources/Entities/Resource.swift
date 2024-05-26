//
//  Resource.swift
//  ProfileDomain
//
//  Created by Ivan Semenov on 27.05.2024.
//

import Foundation

public struct Resource: Equatable {
    let data: Data
    let fileName: String

    public init(data: Data, fileName: String) {
        self.data = data
        self.fileName = fileName
    }
}
