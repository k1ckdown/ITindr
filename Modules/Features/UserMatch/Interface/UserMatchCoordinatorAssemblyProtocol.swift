//
//  UserMatchCoordinatorAssemblyProtocol.swift
//  UserMatchInterface
//
//  Created by Ivan Semenov on 07.06.2024.
//

import Navigation

@MainActor
public protocol UserMatchCoordinatorAssemblyProtocol {
    func assemble(cancelHandler: () -> Void, navigationController: NavigationController) -> UserMatchCoordinatorProtocol
}
