//
//  ProfileEditorCoordinator.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UIKit
import Navigation
import ProfileEditorInterface

final class ProfileEditorCoordinator: BaseCoordinator, ProfileEditorCoordinatorProtocol {
    typealias Content = (ProfileEditorMiddlewareDelegate) -> UIViewController

    private let content: Content
    private let navigationTitle: String?
    private let flowFinishHandler: (() -> Void)?

    init(content: @escaping Content, navigationTitle: String?, flowFinishHandler: (() -> Void)?, navigationController: NavigationController) {
        self.content = content
        self.navigationTitle = navigationTitle
        self.flowFinishHandler = flowFinishHandler
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        content.navigationItem.title = navigationTitle
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - ProfileEditorMiddlewareDelegate

extension ProfileEditorCoordinator: ProfileEditorMiddlewareDelegate {

    func goToNext() {
        flowFinishHandler?()
    }
}
