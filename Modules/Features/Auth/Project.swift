
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "Auth",
    dependencies: [
        .project(target: "AuthDomain", path: "../../Shared/Domain/AuthDomain"),
        .project(target: "CommonUI", path: "../../Shared/Core/CommonUI"),
        .project(target: "Navigation", path: "../../Shared/Core/Navigation"),
        .project(target: "UDFKit", path: "../../Shared/Core/UDFKit")
    ]
)
