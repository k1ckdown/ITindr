//
//  SceneDelegate.swift
//  ITindr
//
//  Created by Ivan Semenov on 20.05.2024.
//

import UIKit
import Navigation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationController = NavigationController()
        navigationController.overrideUserInterfaceStyle = .light

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let appCoordinator = AppCoordinator(navigationController: navigationController)
        self.appCoordinator = appCoordinator

        appCoordinator.start()
    }
}
