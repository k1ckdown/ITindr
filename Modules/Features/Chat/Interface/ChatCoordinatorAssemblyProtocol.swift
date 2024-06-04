//
//  ChatCoordinatorAssemblyProtocol.swift
//  ChatInterface
//
//  Created by Ivan Semenov on 04.06.2024.
//

import Navigation

@MainActor
public protocol ChatCoordinatorAssemblyProtocol {
    func assemble(chatId: String, navigationController: NavigationController) -> ChatCoordinatorProtocol
}
