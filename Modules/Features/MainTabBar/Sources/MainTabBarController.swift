//
//  MainTabBarController.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import CommonUI
import Navigation

final class MainTabBarController: UITabBarController, NavigationBarHidden {

    override func viewDidLoad() {
        tabBar.tintColor = Colors.accentColor.color
    }
}
