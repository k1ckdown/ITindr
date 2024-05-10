
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dataFramework(
    name: "Auth",
    dependencies: [
        .project(target: "Network", path: "../../Core/Network"),
        .project(target: "Keychain", path: "../../Core/Keychain")
    ]
)
