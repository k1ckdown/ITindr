//
//  ProfileEditorCoordinatorAssemblyProtocol.swift
//  ProfileEditorInterface
//
//  Created by Ivan Semenov on 23.05.2024.
//

@MainActor
public protocol ProfileEditorCoordinatorAssemblyProtocol {
    func assemble(flowFinishHandler: (() -> Void)?) -> ProfileEditorCoordinatorProtocol
}
