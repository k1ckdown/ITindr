
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
                ]),
                "UIApplicationSceneManifest": .dictionary([
                    "UISceneConfigurations": .dictionary([
                        "UIWindowSceneSessionRoleApplication": .array([
                            .dictionary([
                                "UISceneConfigurationName": .string("Default Configuration"),
                                "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                            ])
                        ])
                    ])
                ])
            ]),
            sources: Constants.sources,
            resources: Constants.resources,
            dependencies: [
                .project(target: "Auth", path: "../Modules/Features/Auth"),
                .project(target: "Network", path: "../Modules/Shared/Core/Network"),
                .project(target: "AuthData", path: "../Modules/Shared/Data/AuthData"),
                .project(target: "Navigation", path: "../Modules/Shared/Core/Navigation")
            ]
        )
    ]
)
