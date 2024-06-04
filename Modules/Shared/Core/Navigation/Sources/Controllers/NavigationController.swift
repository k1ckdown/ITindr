//
//  NavigationController.swift
//  Navigation
//
//  Created by Ivan Semenov on 19.05.2024.
//

import SwiftUI

typealias PopHandler = (UIViewController) -> Bool

public final class NavigationController: UINavigationController {

    private var popHandlers = [PopHandler]()

    public override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        navigationBar.tintColor = NavigationAsset.accentColor.color
        navigationBar.titleTextAttributes = [.foregroundColor: NavigationAsset.accentColor.color]
    }
}

// MARK: - Public methods

extension NavigationController {

    func addPopHandler(_ handler: @escaping PopHandler) {
        popHandlers.append(handler)
    }

    public func removeAllPopHandlers() {
        popHandlers.removeAll()
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isNavigationBarHidden = viewController is NavigationBarHidden
        let isTabBarHidden = viewController is TabBarHidden

        navigationController.tabBarController?.tabBar.isHidden = isTabBarHidden
        navigationController.setNavigationBarHidden(isNavigationBarHidden, animated: false)
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            navigationController.viewControllers.contains(fromViewController) == false
        else { return }

        popHandlers = popHandlers.filter { $0(fromViewController) }
    }
}
