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

    func goToEditor(_ profile: UserProfile) {
        let editorProfile = getEditorProfile(from: profile)
        let config = getEditorConfig(with: editorProfile)
        let editorCoordinator = profileEditorCoordinatorAssembly.assemble(config: config)

        coordinate(to: editorCoordinator)
    }
}

// MARK: - Private methods

private extension ProfileCoordinator {

    func getEditorProfile(from profile: UserProfile) -> Profile {
        Profile(
            id: profile.id,
            name: profile.name,
            avatarUrl: profile.avatarUrl,
            aboutMyself: profile.aboutMyself,
            topics: profile.topics.map { .init(id: $0.id, title: $0.title) },
            avatarData: profile.avatarData
        )
    }

    func getEditorConfig(with profile: Profile) -> ProfileEditorConfig {
        ProfileEditorConfig(
            profile: profile,
            screenTitle: ProfileStrings.aboutYourself,
            interestsHeader: ProfileStrings.interests,
            navigationTitle: ProfileStrings.editing,
            flowFinishHandler: { [weak self] in self?.navigationController.popViewController(animated: true) },
            navigationController: navigationController
        )
    }
}
