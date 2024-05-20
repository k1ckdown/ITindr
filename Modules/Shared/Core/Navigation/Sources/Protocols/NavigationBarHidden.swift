//
//  NavigationBarHidden.swift
//  Navigation
//
//  Created by Ivan Semenov on 20.05.2024.
//

import SwiftUI

public protocol NavigationBarHidden {}

extension UIHostingController: NavigationBarHidden where Content : NavigationBarHidden {}
