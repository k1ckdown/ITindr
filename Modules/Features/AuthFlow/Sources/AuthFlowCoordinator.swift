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

    private let flowFinishHandler: (() -> Void)?
    private let authCoordinatorAssembly: AuthCoordinatorAssemblyProtocol
    private let profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol

    init(
        flowFinishHandler: (() -> Void)?,
        authCoordinatorAssembly: AuthCoordinatorAssemblyProtocol,
        profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol,
        navigationController: NavigationController
    ) {
        self.flowFinishHandler = flowFinishHandler
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
            loginFinishedHandler: flowFinishHandler,
            registrationFinishedHandler: goToProfileEditor
        )
        coordinate(to: authCoordinator)
    }

    func goToProfileEditor() {
        let config = ProfileEditorConfig(
            profile: .empty,
            screenTitle: AuthFlowStrings.tellAboutYourself,
            interestsHeader: AuthFlowStrings.chooseInterests,
            flowFinishHandler: flowFinishHandler,
            navigationController: navigationController
        )

        let profileEditorCoordinator = profileEditorCoordinatorAssembly.assemble(config: config)
        coordinate(to: profileEditorCoordinator)
    }
}
