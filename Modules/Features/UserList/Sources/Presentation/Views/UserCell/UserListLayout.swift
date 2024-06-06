//
//  UserListLayout.swift
//  UserList
//
//  Created by Ivan Semenov on 06.06.2024.
//

import UIKit

final class UserListLayout: UICollectionViewFlowLayout {

    override var collectionViewContentSize: CGSize {
        .init(width: collectionWidth, height: collectionHeight)
    }

    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []

    private var collectionHeight: CGFloat = 0
    private var collectionWidth: CGFloat {
        guard let collectionView else { return 0 }

        let inset = collectionView.contentInset
        return collectionView.bounds.size.width - inset.left - inset.right
    }

    override func prepare() {
        cachedAttributes.removeAll()
        guard let collectionView else { return }

        let contentWidth = collectionWidth - (Constants.numberOfColumns - 1) * Constants.itemSpacing
        let itemWidth = contentWidth / Constants.numberOfColumns

        var currentY: CGFloat = 0
        var currentX: CGFloat = 0
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        for i in 0..<numberOfItems {
            let indexPath = IndexPath(item: i, section: 0)
            let isLastColumn = (i + 1) % Int(Constants.numberOfColumns) == 0
            let itemFrame = CGRect(x: currentX, y: currentY, width: itemWidth, height: Constants.itemHeight)

            if isLastColumn {
                currentX = 0
                currentY += Constants.itemHeight + Constants.lineSpacing
            } else {
                currentX += itemWidth + Constants.itemSpacing
                let offsetY = Constants.itemHeight / 2
                currentY += i % Int(Constants.numberOfColumns) == 0 ? offsetY : -offsetY
            }

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = itemFrame

            collectionHeight = max(collectionHeight, itemFrame.maxY)
            cachedAttributes.append(attributes)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cachedAttributes[indexPath.item]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cachedAttributes.filter { $0.frame.intersects(rect) }
    }
}

// MARK: - Constants

private extension UserListLayout {

    enum Constants {
        static let itemHeight: CGFloat = 140
        static let lineSpacing: CGFloat = 24
        static let itemSpacing: CGFloat = 16
        static let numberOfColumns: CGFloat = 3
    }
}
