//
//  ChatListCoordinatorAssemblyProtocol.swift
//  ChatListInterface
//
//  Created by Ivan Semenov on 02.06.2024.
//

import Navigation

@MainActor
public protocol ChatListCoordinatorAssemblyProtocol {
    func assemble(navigationController: NavigationController) -> ChatListCoordinatorProtocol
}
