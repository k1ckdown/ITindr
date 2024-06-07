//
//  UserMatchCoordinator.swift
//  UserMatch
//
//  Created by Ivan Semenov on 07.06.2024.
//

import UIKit
import Navigation
import ChatDomain
import ChatInterface
import UserMatchInterface

final class UserMatchCoordinator: BaseCoordinator, UserMatchCoordinatorProtocol {
    typealias Content = (UserMatchMiddlewareDelegate) -> UIViewController

    private var dismiss: (() -> Void)?
    private let content: Content
    private let chatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol

    init(content: @escaping Content, chatCoordinatorAssembly: ChatCoordinatorAssemblyProtocol, navigationController: NavigationController) {
        self.content = content
        self.chatCoordinatorAssembly = chatCoordinatorAssembly
        super.init(navigationController: navigationController)
    }

    override func start() {
        let content = content(self)

        addPopHandler(for: content)
        navigationController.pushViewController(content, animated: true)
    }

    func present() {
        let content = content(self)
        dismiss = { [weak content] in content?.dismiss(animated: false) }

        content.modalPresentationStyle = .overFullScreen
        navigationController.present(content, animated: true)
    }
}

// MARK: - UserMatchMiddlewareDelegate

extension UserMatchCoordinator: UserMatchMiddlewareDelegate {

    func goToChat(_ chat: ChatDomain.Chat) {
        dismiss?()
        let interfaceChat = ChatInterface.Chat(id: chat.id, title: chat.title, avatarUrl: chat.avatar)
        let chatCoordinator = chatCoordinatorAssembly.assemble(chat: interfaceChat, navigationController: navigationController)
        coordinate(to: chatCoordinator)
    }
}
