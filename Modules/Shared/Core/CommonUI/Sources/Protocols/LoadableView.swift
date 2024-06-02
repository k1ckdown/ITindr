//
//  LoadableView.swift
//  CommonUI
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UIKit

public protocol LoadableView {
    var loadingView: UIActivityIndicatorView { get }
}

public extension LoadableView where Self: UIViewController {

    func isLoading(_ value: Bool) {
        value ? loadingView.startAnimating() : loadingView.stopAnimating()
    }
    
    func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        loadingView.color = Colors.accentColor.color
        loadingView.backgroundColor = view.backgroundColor
    }
}
