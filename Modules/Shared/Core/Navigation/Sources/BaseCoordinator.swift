//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by Ivan Semenov on 19.05.2024.
//

import UIKit

public class BaseCoordinator: Coordinator {

    public weak var parentCoordinator: Coordinator?
    private let navigationController: NavigationController

    private var childCoordinators = [Coordinator]()

    public init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        fatalError("Start method should be implemented")
    }

    public func coordinate(to coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)

        coordinator.start()
    }

    public func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }

    public func didFinish(coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        childCoordinators.remove(at: index)
    }

    public func setupPopHandler(for viewController: UIViewController) {
        let popHandler: PopHandler = { [weak self, weak viewController] fromViewController in
            guard let self, fromViewController === viewController else { return true }

            parentCoordinator?.didFinish(coordinator: self)
            return false
        }

        navigationController.addPopHandler(popHandler)
    }
}
