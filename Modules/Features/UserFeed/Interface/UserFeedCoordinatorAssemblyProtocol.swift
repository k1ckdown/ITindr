//
//  UserFeedCoordinatorAssemblyProtocol.swift
//  UserFeedInterface
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation

@MainActor
public protocol UserFeedCoordinatorAssemblyProtocol {
    func assemble(navigationController: NavigationController) -> UserFeedCoordinatorProtocol
}
