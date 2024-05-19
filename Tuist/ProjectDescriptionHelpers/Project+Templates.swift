//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Ivan Semenov on 09.05.2024.
//

import ProjectDescription

extension Project {

    public static func coreFramework(
        name: String,
        dependencies: [TargetDependency] = [],
        includeResources: Bool = false
    ) -> Project {
        Project(
            name: name,
            targets: [
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticLibrary,
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

    public static func domainFramework(
        name: String,
        dependencies: [String] = []
    ) -> Project {
        let projectName = "\(name)Domain"

        return Project(
            name: projectName,
            targets: [
                .target(
                    name: projectName,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(projectName)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: Constants.sources,
                    dependencies: dependencies.map {
                        let projectName = "\($0)Domain"
                        return .project(target: projectName, path: "../\(projectName)")
                    }
                )
            ]
        )
    }

    public static func dataFramework(
        name: String,
        dependencies: [TargetDependency] = [],
        includeResources: Bool = false
    ) -> Project {
        let dataProject = "\(name)Data"
        let domainProject = "\(name)Domain"

        return Project(
            name: dataProject,
            targets: [
                .target(
                    name: dataProject,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(dataProject)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: Constants.sources,
                    resources: includeResources ? Constants.resources : nil,
                    dependencies: dependencies + [
                        .project(target: domainProject, path: "../../Domain/\(domainProject)")
                    ]
                )
            ]
        )
    }

    public static func featureFramework(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Project {
        let interfaceProject = "\(name)Interface"

        return Project(
            name: name,
            targets: [
                .target(
                    name: interfaceProject,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(interfaceProject)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: "Interface/**"
                ),
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .framework,
                    bundleId: "\(Constants.bundleId).\(name)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: Constants.sources,
                    resources: Constants.resources,
                    dependencies: dependencies + [
                        .project(target: interfaceProject, path: "../\(name)")
                    ]
                )
            ]
        )
    }
}
