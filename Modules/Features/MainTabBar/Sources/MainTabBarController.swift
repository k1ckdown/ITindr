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
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

private extension MainTabBarController {

    func setup() {
        tabBar.backgroundColor = .white
        setupTabBarItem()
        setupShadowLayer()
    }

    func setupTabBarItem() {
        tabBar.tintColor = Colors.accentColor.color
        tabBar.unselectedItemTintColor = Colors.appDarkGray.color
        UITabBarItem.appearance().setTitleTextAttributes([.font: Fonts.uiMedium10], for: .normal)
    }

    func setupShadowLayer() {
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowRadius = Constants.shadowRadius
        tabBar.layer.shadowOffset = Constants.shadowOffset
        tabBar.layer.shadowOpacity = Constants.shadowOpacity
    }
}

// MARK: - Constants

private extension MainTabBarController {

    enum Constants {
        static let shadowRadius: CGFloat = 10
        static let shadowOpacity: Float = 0.3
        static let shadowOffset = CGSize(width: 0, height: -1)
    }
}
