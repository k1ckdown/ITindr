//
//  Binding+Extensions.swift
//  CommonUI
//
//  Created by Ivan Semenov on 21.05.2024.
//

import SwiftUI

public extension Binding {

    init(_ value: Value, set: @escaping (Value) -> Void) {
        self.init(
            get: { value },
            set: set
        )
    }
}
