//
//  TabBarHidden.swift
//  Navigation
//
//  Created by Ivan Semenov on 05.06.2024.
//

import SwiftUI

public protocol TabBarHidden {}

extension UIHostingController: TabBarHidden where Content: TabBarHidden {}
