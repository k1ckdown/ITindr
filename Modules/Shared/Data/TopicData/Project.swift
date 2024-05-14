
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dataFramework(
    name: "Topic",
    dependencies: [
        .project(target: "Network", path: "../../Core/Network")
    ]
)
