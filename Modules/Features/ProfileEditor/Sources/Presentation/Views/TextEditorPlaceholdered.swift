//
//  TextEditorPlaceholdered.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 09.06.2024.
//

import SwiftUI
import CommonUI

struct TextEditorPlaceholdered: View {
    
    @Binding var text: String
    let placeholder: String
    
    init(text: Binding<String>, placeholder: String) {
        _text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(Colors.appDarkGray.swiftUIColor)
                    .padding(.vertical, Constants.defaultVerticalInset)
                    .padding(.horizontal, Constants.defaultHorizontalInset)
            }
            
            TextEditor(text: $text)
        }
    }
}

// MARK: - Constants

private extension TextEditorPlaceholdered {
    
    enum Constants {
        static let defaultVerticalInset: CGFloat = 10
        static let defaultHorizontalInset: CGFloat = 6
    }
}
