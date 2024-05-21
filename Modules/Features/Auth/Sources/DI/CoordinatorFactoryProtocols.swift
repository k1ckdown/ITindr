//
//  CoordinatorFactoryProtocols.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Navigation

@MainActor
protocol StartCoordinatorFactory {
    func makeStartCoordinator(navigationController: NavigationController) -> StartCoordinator
}

@MainActor
protocol RegistrationCoordinatorFactory {
    func makeRegistrationCoordinator(navigationController: NavigationController) -> RegistrationCoordinator
}
