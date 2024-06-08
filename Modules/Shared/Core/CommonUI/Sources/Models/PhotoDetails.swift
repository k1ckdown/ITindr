//
//  PhotoDetails.swift
//  CommonUI
//
//  Created by Ivan Semenov on 08.06.2024.
//

import UIKit

public struct PhotoDetails: Equatable {
    public let image: UIImage
    public let fileName: String

    public init(image: UIImage, fileName: String) {
        self.image = image
        self.fileName = fileName
    }
}
