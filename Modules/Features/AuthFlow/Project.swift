
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "AuthFlow",
    hasResources: false,
    dependencies: [
        .project(target: "Auth", path: "../Auth"),
        .project(target: "ProfileEditor", path: "../ProfileEditor")
    ]
)
