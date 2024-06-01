//
//  MainTabBarCoordinator.swift
//  MainTabBar
//
//  Created by Ivan Semenov on 27.05.2024.
//

import UIKit
import Navigation
import ProfileInterface
import ChatListInterface
import UserFeedInterface
import UserListInterface
import MainTabBarInterface

final class MainTabBarCoordinator: BaseCoordinator, MainTabBarCoordinatorProtocol {

    private let profileCoordinatorAssembly: ProfileCoordinatorAssemblyProtocol
    private let chatListCoordinatorAssembly: ChatListCoordinatorAssemblyProtocol
    private let userFeedCoordinatorAssembly: UserFeedCoordinatorAssemblyProtocol
    private let userListCoordinatorAssembly: UserListCoordinatorAssemblyProtocol

    public init(
        navigationController: NavigationController,
        profileCoordinatorAssembly: ProfileCoordinatorAssemblyProtocol,
        chatListCoordinatorAssembly: ChatListCoordinatorAssemblyProtocol,
        userFeedCoordinatorAssembly: UserFeedCoordinatorAssemblyProtocol,
        userListCoordinatorAssembly: UserListCoordinatorAssemblyProtocol
    ) {
        self.profileCoordinatorAssembly = profileCoordinatorAssembly
        self.chatListCoordinatorAssembly = chatListCoordinatorAssembly
        self.userFeedCoordinatorAssembly = userFeedCoordinatorAssembly
        self.userListCoordinatorAssembly = userListCoordinatorAssembly
        super.init(navigationController: navigationController)
    }

    override func start() {
        let tabBarController = MainTabBarController()
        let viewControllers = TabFlow.allCases.map(makeViewController)

        tabBarController.setViewControllers(viewControllers, animated: false)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

// MARK: - Private methods

private extension MainTabBarCoordinator {

    func makeViewController(for tab: TabFlow) -> UIViewController {
        let navigationController = NavigationController()
        navigationController.tabBarItem = UITabBarItem(title: tab.title, image: tab.image, tag: tab.tag)

        let coordinator: Coordinator = switch tab {
        case .userFeed: userFeedCoordinatorAssembly.assemble(navigationController: navigationController)
        case .userList: userListCoordinatorAssembly.assemble(navigationController: navigationController)
        case .chatList: chatListCoordinatorAssembly.assemble(navigationController: navigationController)
        case .profile: profileCoordinatorAssembly.assemble(navigationController: navigationController)
        }

        coordinate(to: coordinator)
        return navigationController
    }
}
