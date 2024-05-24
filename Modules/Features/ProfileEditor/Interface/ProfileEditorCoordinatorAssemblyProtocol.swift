//
//  ProfileEditorCoordinatorAssemblyProtocol.swift
//  ProfileEditorInterface
//
//  Created by Ivan Semenov on 23.05.2024.
//

import Navigation

@MainActor
public protocol ProfileEditorCoordinatorAssemblyProtocol {
    func assemble(navigationController: NavigationController, flowFinishHandler: (() -> Void)?) -> ProfileEditorCoordinatorProtocol
}
