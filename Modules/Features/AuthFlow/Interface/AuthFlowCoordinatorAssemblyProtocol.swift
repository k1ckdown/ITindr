//
//  AuthFlowCoordinatorAssemblyProtocol.swift
//  AuthFlowInterface
//
//  Created by Ivan Semenov on 25.05.2024.
//

@MainActor
protocol AuthFlowCoordinatorAssemblyProtocol {
    func assemble(flowFinishHandler: (() -> Void)?) -> AuthFlowCoordinatorProtocol
}
