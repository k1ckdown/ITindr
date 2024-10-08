//
//  AuthCoordinatorAssemblyProtocol.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 20.05.2024.
//

import Navigation

@MainActor
public protocol AuthCoordinatorAssemblyProtocol {
    func assemble(
        navigationController: NavigationController,
        loginFinishedHandler: (() -> Void)?,
        registrationFinishedHandler: (() -> Void)?
    ) -> AuthCoordinatorProtocol
}
