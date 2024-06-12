
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "AuthFlow",
    hasResources: true,
    dependencies: [
        .project(target: "AuthInterface", path: "../Auth"),
        .project(target: "ProfileEditorInterface", path: "../ProfileEditor")
    ]
)
