//
//  ReuseIdentifiable.swift
//  CommonUI
//
//  Created by Ivan Semenov on 03.06.2024.
//

import UIKit

public protocol ReuseIdentifiable {}

public extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionReusableView: ReuseIdentifiable {}
