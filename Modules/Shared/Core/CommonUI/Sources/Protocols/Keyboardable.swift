//
//  Keyboardable.swift
//  CommonUI
//
//  Created by Ivan Semenov on 08.06.2024.
//

import UIKit

public protocol Keyboardable {}

public extension Keyboardable where Self: UIViewController {

    func registerKeyboardWillHideNotification(_ block: (() -> Void)? = nil) {
        let notificationName = UIResponder.keyboardWillHideNotification

        NotificationCenter.default.addObserver(
            forName: notificationName,
            object: nil,
            queue: nil,
            using: { _ in block?() }
        )
    }
    
    func registerKeyboardWillShowNotification(_ block: ((CGRect) -> Void)? = nil) {
        let notificationName = UIResponder.keyboardWillShowNotification
        let notificationBlock: (Notification) -> Void = {
            if let keyboardFrame = $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                block?(keyboardFrame)
            }
        }

        NotificationCenter.default.addObserver(
            forName: notificationName,
            object: nil,
            queue: nil,
            using: notificationBlock
        )
    }
}
