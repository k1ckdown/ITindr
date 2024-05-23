//
//  View+Extensions.swift
//  CommonUI
//
//  Created by Ivan Semenov on 23.05.2024.
//

import SwiftUI

public extension View {

    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}
