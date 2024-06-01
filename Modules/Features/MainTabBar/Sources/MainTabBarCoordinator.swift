//
//  MainTabBarCoordinator.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 27.05.2024.
//

import UIKit
import Navigation
import MainTabBarInterface

final class MainTabBarCoordinator: BaseCoordinator, MainTabBarCoordinatorProtocol {

    override func start() {
        let tabBarController = MainTabBarController()
        let viewControllers = TabFlow.allCases.map(makeViewController)

        tabBarController.setViewControllers(viewControllers, animated: true)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

// MARK: - Private methods

private extension MainTabBarCoordinator {

    func makeViewController(for tab: TabFlow) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: .init())
        let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, tag: tab.tag)

        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}
