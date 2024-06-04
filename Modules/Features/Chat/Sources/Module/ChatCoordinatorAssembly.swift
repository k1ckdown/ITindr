//
//  ChatCoordinatorAssembly.swift
//  Chat
//
//  Created by Ivan Semenov on 04.06.2024.
//

import Navigation
import ChatInterface

public struct ChatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol {

    private let dependencies: ModuleDependencies

    public init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }

    public func assemble(navigationController: NavigationController) -> ChatCoordinatorProtocol {
        ChatCoordinator(navigationController: navigationController)
    }
}
