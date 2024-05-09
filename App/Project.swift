import ProjectDescription

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
            bundleId: "com.ITindr",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen.storyboard",
                "UISupportedInterfaceOrientations": .array([
                    .string("UIInterfaceOrientationPortrait")
                ])
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
