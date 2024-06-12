//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import ProfileDomain
import ProfileInterface
import ProfileEditorInterface

final class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorProtocol {
    typealias Content = (ProfileMiddlewareDelegate) -> UIViewController

    private let content: Content
    private let profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol

    init(
        content: @escaping Content,
        navigationController: NavigationController,
        profileEditorCoordinatorAssembly: ProfileEditorCoordinatorAssemblyProtocol
    ) {
        self.content = content
        self.profileEditorCoordinatorAssembly = profileEditorCoordinatorAssembly
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        content.navigationItem.title = ProfileStrings.profile
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - ProfileMiddlewareDelegate

extension ProfileCoordinator: ProfileMiddlewareDelegate {

    func goToEditor(_ user: UserProfile) {
        let editorProfile = Profile(
            id: user.id,
            name: user.name,
            avatarUrl: user.avatarUrl,
            aboutMyself: user.aboutMyself,
            topics: user.topics.map { .init(id: $0.id, title: $0.title) },
            avatarData: user.avatarData
        )

        let editorCoordinator = profileEditorCoordinatorAssembly.assemble(
            profile: editorProfile,
            isNavigationBarHidden: false,
            navigationController: navigationController,
            flowFinishHandler: { [weak self] in self?.navigationController.popViewController(animated: true) }
        )
        coordinate(to: editorCoordinator)
    }
}
