//
//  UserFeedCoordinator.swift
//  UserFeed
//
//  Created by Ivan Semenov on 02.06.2024.
//

import UIKit
import Navigation
import UserFeedInterface

final class UserFeedCoordinator: BaseCoordinator, UserFeedCoordinatorProtocol {
    typealias Content = (FeedMiddlewareDelegate) -> UIViewController

    private let factory: CoordinatorFactory
    private let content: Content

    init(content: @escaping Content, factory: CoordinatorFactory, navigationController: NavigationController) {
        self.content = content
        self.factory = factory
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }
}

extension UserFeedCoordinator: FeedMiddlewareDelegate {

}
