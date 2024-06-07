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
        hasResources: Bool = false,
        dependencies: [TargetDependency] = []
    ) -> Project {
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
                    resources: getResourceFileElements(hasResources),
                    dependencies: dependencies
                )
            ]
        )
    }
    
    public static func domainFramework(
        name: String,
        hasCommon: Bool = false,
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
                    } + (hasCommon ? [.project(target: "CommonDomain", path: "../../Core/CommonDomain")] : [])
                )
            ]
        )
    }
    
    public static func dataFramework(
        name: String,
        domainName: String? = nil,
        dependencies: [TargetDependency] = [],
        hasResources: Bool = false
    ) -> Project {
        let dataProject = "\(name)Data"
        let domainProject = "\(domainName ?? name)Domain"
        
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
                    resources:  getResourceFileElements(hasResources),
                    dependencies: dependencies + [
                        .project(target: domainProject, path: "../../Domain/\(domainProject)")
                    ]
                )
            ]
        )
    }
    
    public static func featureFramework(
        name: String,
        hasNavigation: Bool = true,
        hasResources: Bool = true,
        dependencies: [TargetDependency] = []
    ) -> Project {
        let interfaceProject = "\(name)Interface"
        let navigation: [TargetDependency] = hasNavigation ? [.project(target: "Navigation", path: "../../Shared/Core/Navigation")] : []
        
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
                    sources: "Interface/**",
                    dependencies: navigation
                ),
                .target(
                    name: name,
                    destinations: .iOS,
                    product: .staticFramework,
                    bundleId: "\(Constants.bundleId).\(name)",
                    deploymentTargets: .iOS(Constants.iOSVersion),
                    infoPlist: .default,
                    sources: Constants.sources,
                    resources: getResourceFileElements(hasResources),
                    dependencies: dependencies + navigation + [
                        .project(target: interfaceProject, path: "../\(name)")
                    ]
                )
            ]
        )
    }
    
    private static func getResourceFileElements(_ include: Bool) -> ResourceFileElements? {
        include ? Constants.resources : nil
    }
}
