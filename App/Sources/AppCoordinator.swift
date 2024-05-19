//
//  AppCoordinator.swift
//  ITindr
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Navigation

final class AppCoordinator: BaseCoordinator {

    override func start() {
        navigationController.setViewControllers([.init()], animated: false)
    }
}
