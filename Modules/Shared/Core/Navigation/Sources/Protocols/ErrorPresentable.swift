//
//  ErrorPresentable.swift
//  Navigation
//
//  Created by Ivan Semenov on 22.05.2024.
//

import UIKit

@MainActor
public protocol ErrorPresentable {
    func showError(_ message: String)
}

public extension ErrorPresentable where Self: BaseCoordinator {

    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        navigationController.present(alertController, animated: true)
    }
}
