//
//  NavigationController.swift
//  Navigation
//
//  Created by Ivan Semenov on 19.05.2024.
//

import UIKit

typealias PopHandler = (UIViewController) -> Bool

public final class NavigationController: UINavigationController {
    private var popHandlers = [PopHandler]()
}

// MARK: - Public methods

extension NavigationController {

    func removeAllPopHandlers() {
        popHandlers.removeAll()
    }

    func addPopHandler(_ handler: @escaping PopHandler) {
        popHandlers.append(handler)
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            navigationController.contains(fromViewController) == false
        else { return }

        popHandlers = popHandlers.filter { $0(fromViewController) }
    }
}
