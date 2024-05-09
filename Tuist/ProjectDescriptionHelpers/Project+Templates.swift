//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Ivan Semenov on 09.05.2024.
//

import ProjectDescription

extension Project {

    public static func coreFramework(name: String, dependencies: [TargetDependency] = [], includeResources: Bool = false) -> Project {
        Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(name)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: Constants.sources,
                    resources: includeResources ? Constants.resources : nil,
                    dependencies: dependencies
                )
            ]
        )
    }

    public static func featureFramework(name: String, dependencies: [TargetDependency] = []) -> Project {
        let interfaceName = "\(name)Interface"

        return Project(
            name: name,
            targets: [
                .target(
                    name: interfaceName,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(interfaceName)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: "Interface/**"
                ),
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(name)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: Constants.sources,
                    resources: Constants.resources,
                    dependencies: dependencies + [
                        .project(target: interfaceName, path: "../\(name)")
                    ]
                )
            ]
        )
    }
}
