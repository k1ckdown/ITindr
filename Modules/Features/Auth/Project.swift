
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "Auth",
    dependencies: [
        .project(target: "AuthDomain", path: "../../Shared/Domain/AuthDomain"),
        .project(target: "CommonUI", path: "../../Shared/Core/CommonUI"),
        .project(target: "UDFKit", path: "../../Shared/Core/UDFKit"),
        .project(target: "Validation", path: "../../Shared/Core/Validation")
    ]
)
