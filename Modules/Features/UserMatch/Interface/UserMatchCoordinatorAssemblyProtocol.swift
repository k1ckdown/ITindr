//
//  UserMatchCoordinatorAssemblyProtocol.swift
//  UserMatchInterface
//
//  Created by Ivan Semenov on 07.06.2024.
//

import Navigation

@MainActor
public protocol UserMatchCoordinatorAssemblyProtocol {
    func assemble(
        userId: String,
        cancelHandler: (() -> Void)?,
        navigationController: NavigationController
    ) -> UserMatchCoordinatorProtocol
}
