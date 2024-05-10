
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ITindr",
    settings: .settings(
        base: [
            "INFOPLIST_KEY_CFBundleDisplayName": .string("ITindr"),
            "INFOPLIST_KEY_LSApplicationCategoryType": .string("public.app-category.social-networking")
        ]
    ),
    targets: [
        .target(
            name: "ITindr",
            destinations: .iOS,
            product: .app,
            bundleId: Constants.bundleId,
            deploymentTargets: .iOS(Constants.iOSVersion),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen.storyboard",
                "UISupportedInterfaceOrientations": .array([
                    .string("UIInterfaceOrientationPortrait")
                ]),
                "NSAppTransportSecurity": .dictionary([
                    "NSAllowsArbitraryLoads": .boolean(true)
                ])
            ]),
            sources: Constants.sources,
            resources: Constants.resources,
            dependencies: [
                .project(target: "Network", path: "../Modules/Shared/Core/Network"),
                .project(target: "AuthData", path: "../Modules/Shared/Data/AuthData")
            ]
        )
    ]
)
