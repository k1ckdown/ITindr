//
//  TagLayout.swift
//  CommonUI
//
//  Created by Ivan Semenov on 08.06.2024.
//

import SwiftUI

public struct TagLayout<Data, RowContent>: View where Data: RandomAccessCollection,
                                               RowContent: View,
                                               Data.Element: Identifiable,
                                               Data.Element: Hashable {

    @State private var height = CGFloat.zero

    private let data: Data
    private let spacing: CGFloat
    private let rowContent: (Data.Element) -> RowContent

    public init(_ data: Data, spacing: CGFloat = 5, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.spacing = spacing
        self.rowContent = rowContent
    }

    public var body: some View {
        GeometryReader { geometry in
            content(in: geometry).background(viewHeight(for: $height))
        }
        .frame(height: height)
    }
}

// MARK: - Private methods

private extension TagLayout {

    func viewHeight(for binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry in
            let rect = geometry.frame(in: .local)

            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }

            return Color.clear
        }
    }

    @ViewBuilder
    func content(in geometry: GeometryProxy) -> some View {
        var bounds = CGSize.zero

        ZStack {
            ForEach(data) { item in
                rowContent(item)
                    .padding(.all, spacing)
                    .alignmentGuide(VerticalAlignment.center) { _ in
                        let result = bounds.height

                        if item == data.first {
                            bounds.height = 0
                        }

                        return result
                    }
                    .alignmentGuide(HorizontalAlignment.center) { dimension in
                        if geometry.size.width < abs(bounds.width - dimension.width) {
                            bounds.width = 0
                            bounds.height -= dimension.height
                        }

                        let result = bounds.width
                        bounds.width = item == data.first ? 0 : bounds.width - dimension.width

                        return result
                    }
            }
        }
    }
}
