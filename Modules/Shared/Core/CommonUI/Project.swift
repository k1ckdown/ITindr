
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.coreFramework(
    name: "CommonUI",
    hasResources: true,
    dependencies: [
        .external(name: "Kingfisher"),
        .external(name: "WrappingHStack")
    ]
)
