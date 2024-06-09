//
//  NavigationBarHidden.swift
//  Navigation
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI

public protocol NavigationBarHidden {
    var isNavBarHidden: Bool { get }
}

public extension NavigationBarHidden {
    var isNavBarHidden: Bool { true }
}

extension UIHostingController: NavigationBarHidden where Content : NavigationBarHidden {
    public var isNavBarHidden: Bool {
        rootView.isNavBarHidden
    }
}
