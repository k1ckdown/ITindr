
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dataFramework(
    name: "User",
    domainName: "Profile",
    dependencies: [
        .project(target: "Network", path: "../../Core/Network")
    ]
)
