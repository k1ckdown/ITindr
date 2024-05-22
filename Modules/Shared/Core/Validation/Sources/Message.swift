//
//  Message.swift
//  Validation
//
//  Created by Ivan Semenov on 22.05.2024.
//

public func message(_ block: @autoclosure () throws -> ()) -> String? {
    do {
        try block()
        return nil
    } catch {
        return error.localizedDescription
    }
}
