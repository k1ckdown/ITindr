//
//  Coordinator.swift
//  Navigation
//
//  Created by Ivan Semenov on 19.05.2024.
//

public protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }

    func start()
    func removeChildCoordinators()
    func didFinish(coordinator: Coordinator)
}
