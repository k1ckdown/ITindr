//
//  FullScrollView.swift
//  CommonUI
//
//  Created by Ivan Semenov on 08.06.2024.
//

import SwiftUI

public struct FullScrollView<Content: View>: View {

    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                content
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
