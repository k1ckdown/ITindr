//
//  UITextView+Placeholder.swift
//  CommonUI
//
//  Created by Ivan Semenov on 11.06.2024.
//

import UIKit

extension UITextView {

    public var placeholder: String? {
        get { getPlaceholderText() }
        set { setPlaceholderText(newValue) }
    }

    private static let placeholderLabelTag = 941

    public func setupPlaceholderLayout() {
        guard let placeholderLabel = getPlaceholderLabel() else { return }

        placeholderLabel.frame.origin.y = textContainerInset.top
        placeholderLabel.frame.origin.x = textContainerInset.left + 4
        placeholderLabel.frame.size.width = bounds.width - textContainerInset.left - textContainerInset.right
    }
}

// MARK: - Private methods

private extension UITextView {

    func getPlaceholderLabel() -> UILabel? {
        viewWithTag(Self.placeholderLabelTag) as? UILabel
    }

    func getPlaceholderText() -> String? {
        let placeholderLabel = getPlaceholderLabel()
        return placeholderLabel?.text
    }

    func setPlaceholderText(_ text: String?) {
        if let placeholderLabel = getPlaceholderLabel() {
            placeholderLabel.text = text
            placeholderLabel.sizeToFit()
        } else {
            addPlaceholderLabel(with: text)
        }
    }

    @objc
    func handleTextChange() {
        guard let placeholderLabel = getPlaceholderLabel() else { return }
        placeholderLabel.isHidden = text.isEmpty == false
    }

    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }

    func addPlaceholderLabel(with text: String?) {
        let placeholderLabel = UILabel()

        addObserver()
        addSubview(placeholderLabel)

        placeholderLabel.text = text
        placeholderLabel.sizeToFit()
        placeholderLabel.font = font
        placeholderLabel.numberOfLines = 0
        placeholderLabel.tag = Self.placeholderLabelTag
        placeholderLabel.textColor = Colors.appDarkGray.color
        placeholderLabel.isHidden = self.text.isEmpty == false
    }
}
