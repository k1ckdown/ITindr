//
//  UserFeedCoordinator.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import SwiftUI
import Navigation
import ProfileDomain
import UserFeedInterface
import UserMatchInterface

final class UserFeedCoordinator: BaseCoordinator, UserFeedCoordinatorProtocol {
    typealias Content = (FeedMiddlewareDelegate) -> UIViewController

    private let content: Content
    private let factory: CoordinatorFactory
    private let userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol

    init(
        content: @escaping Content,
        factory: CoordinatorFactory,
        navigationController: NavigationController,
        userMatchCoordinatorAssembly: UserMatchCoordinatorAssemblyProtocol
    ) {
        self.content = content
        self.factory = factory
        self.userMatchCoordinatorAssembly = userMatchCoordinatorAssembly
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }
}

// MARK: - FeedMiddlewareDelegate

extension UserFeedCoordinator: FeedMiddlewareDelegate {

    func goToProfile(_ user: UserProfile) {
        let profileCoordinator = factory.makeProfileCoordinator(user: user, navigationController: navigationController)
        coordinate(to: profileCoordinator)
    }

    func showUserMatch(userId: String, cancelHandler: (() -> Void)?) {
        let userMatchCoordinator = userMatchCoordinatorAssembly.assemble(
            userId: userId,
            cancelHandler: cancelHandler,
            navigationController: navigationController
        )

        userMatchCoordinator.present()
    }
}
