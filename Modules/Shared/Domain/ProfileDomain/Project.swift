
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.domainFramework(
    name: "Profile",
    hasCommon: true,
    dependencies: [
        "Topic"
    ]
)
