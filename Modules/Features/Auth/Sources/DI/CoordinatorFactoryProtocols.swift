//
//  CoordinatorFactoryProtocols.swift
//  Auth
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Navigation

protocol StartCoordinatorFactory {
    func makeStartCoordinator(navigationController: NavigationController) -> StartCoordinator
}

protocol RegistrationCoordinatorFactory {
    func makeRegistrationCoordinator(navigationController: NavigationController) -> RegistrationCoordinator
}
