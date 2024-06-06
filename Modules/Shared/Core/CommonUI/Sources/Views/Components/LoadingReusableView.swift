//
//  LoadingReusableView.swift
//  Chat
//
//  Created by Ivan Semenov on 05.06.2024.
//

import UIKit

public final class LoadingReusableView: UICollectionReusableView {

    public var isShowing = false {
        didSet {
            isShowing ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        }
    }

    private let indicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(indicatorView)
        indicatorView.color = Colors.accentColor.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.frame = bounds
    }
}
