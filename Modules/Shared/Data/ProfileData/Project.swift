
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dataFramework(
    name: "Profile",
    dependencies: [
        .project(target: "Network", path: "../../Core/Network"),
        .project(target: "UserCoreData", path: "../../Core/UserCoreData")
    ]
)
