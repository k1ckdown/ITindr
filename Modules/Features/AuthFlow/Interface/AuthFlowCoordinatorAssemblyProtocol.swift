//
//  AuthFlowCoordinatorAssemblyProtocol.swift
//  AuthFlowInterface
//
//  Created by Ivan Semenov on 25.05.2024.
//

import Navigation

@MainActor
public protocol AuthFlowCoordinatorAssemblyProtocol {
    func assemble(navigationController: NavigationController, flowFinishHandler: (() -> Void)?) -> AuthFlowCoordinatorProtocol
}
