//
//  NSSet+ToArray.swift
//  UserCoreData
//
//  Created by Ivan Semenov on 09.06.2024.
//

import Foundation

public extension NSSet {
    func toArray<T>(of type: T.Type) -> [T] {
        allObjects.compactMap { $0 as? T }
    }
}
