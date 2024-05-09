// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ThirdPartyLibraries",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: .init(5, 9, 1))
    ]
)
