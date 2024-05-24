
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "AuthFlow",
    hasResources: false,
    dependencies: [
        .project(target: "AuthInterface", path: "../Auth"),
        .project(target: "ProfileEditorInterface", path: "../ProfileEditor")
    ]
)
