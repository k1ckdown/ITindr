//
//  AuthFlowCoordinator.swift
//  AuthFlow
//
//  Created by Ivan Semenov on 25.05.2024.
//

import Navigation
import AuthInterface
import ProfileEditorInterface
import AuthFlowInterface

final class AuthFlowCoordinator: BaseCoordinator, AuthFlowCoordinatorProtocol {

    private let authCoordinatorAssembly: AuthCoordinatorAssemblyProtocol
    private let profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol

    init(
        authCoordinatorAssembly: AuthCoordinatorAssemblyProtocol,
        profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol,
        navigationController: NavigationController
    ) {
        self.authCoordinatorAssembly = authCoordinatorAssembly
        self.profileEditorCoordinatorAssembly = profileEditorCoordinatorAssembly
        super.init(navigationController: navigationController)
    }

    override func start() {
        goToAuth()
    }
}

// MARK: - Private methods

private extension AuthFlowCoordinator {

    func goToAuth() {
        let authCoordinator = authCoordinatorAssembly.assemble(
            navigationController: navigationController,
            flowFinishHandler: goToProfileEditor
        )
        coordinate(to: authCoordinator)
    }

    func goToProfileEditor() {
        let profileEditorCoordinator = profileEditorCoordinatorAssembly.assemble(
            navigationController: navigationController,
            flowFinishHandler: goToAuth
        )
        coordinate(to: profileEditorCoordinator)
    }
}
