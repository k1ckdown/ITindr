//
//  ClearBackgroundView.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
}
