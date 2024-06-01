//
//  UserListCoordinatorAssemblyProtocol.swift
//  UserListInterface
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation

@MainActor
public protocol UserListCoordinatorAssemblyProtocol {
    func assemble(navigationController: NavigationController) -> UserListCoordinatorProtocol
}
