//
//  TopicList.swift
//  CommonUI
//
//  Created by Ivan Semenov on 09.06.2024.
//

import SwiftUI
import WrappingHStack

public struct TagLayout<Data: RandomAccessCollection, Content: View>: View {

    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    public init(_ data: Data, alignment: HorizontalAlignment = .center, spacing: CGFloat = 8, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        if data.isEmpty == false {
            WrappingHStack(data, alignment: alignment, spacing: .constant(spacing), lineSpacing: spacing) {
                content($0)
            }
        }
    }
}
