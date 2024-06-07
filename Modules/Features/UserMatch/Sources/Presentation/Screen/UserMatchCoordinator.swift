//
//  UserMatchCoordinator.swift
//  UserMatch
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UIKit
import Navigation
import UserMatchInterface

final class UserMatchCoordinator: BaseCoordinator, UserMatchCoordinatorProtocol {
    typealias Content = () -> UIViewController

    private let content: Content

    init(content: @escaping Content, navigationController: NavigationController) {
        self.content = content
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content()

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }

    func present() {
        let content = content()

        content.modalPresentationStyle = .overFullScreen
        navigationController.present(content, animated: true)
    }
}
