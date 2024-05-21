//
//  TextFieldState.swift
//  CommonUI
//
//  Created by Ivan Semenov on 21.05.2024.
//

public struct TextFieldState: Equatable {
    let isRequired: Bool
    public var error: String?
    public var content: String

    public init(content: String = "", error: String? = nil, isRequired: Bool = true) {
        self.content = content
        self.error = error
        self.isRequired = isRequired
    }
    
    public var isErrorShowing: Bool {
        error != nil && content.isEmpty == false
    }

    public var isValid: Bool {
        error != nil && (isRequired == false || isRequired && content.isEmpty == false)
    }
}
