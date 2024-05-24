//
//  AuthCoordinatorAssemblyProtocol.swift
//  AuthInterface
//
//  Created by Ivan Semenov on 20.05.2024.
//

@MainActor
public protocol AuthCoordinatorAssemblyProtocol {
    func assemble(flowFinishHandler: (() -> Void)?) -> AuthCoordinatorProtocol
}
