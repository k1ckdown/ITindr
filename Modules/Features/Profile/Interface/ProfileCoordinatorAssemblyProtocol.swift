//
//  ProfileCoordinatorAssemblyProtocol.swift
//  ProfileInterface
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation

@MainActor
public protocol ProfileCoordinatorAssemblyProtocol {
    func assemble(navigationController: NavigationController) -> ProfileCoordinatorProtocol
}
