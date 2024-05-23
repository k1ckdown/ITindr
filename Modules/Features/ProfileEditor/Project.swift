
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "ProfileEditor",
    dependencies: [
        .project(target: "ProfileDomain", path: "../../Shared/Domain/ProfileDomain"),
        .project(target: "CommonUI", path: "../../Shared/Core/CommonUI"),
        .project(target: "UDFKit", path: "../../Shared/Core/UDFKit"),
        .external(name: "Kingfisher")
    ]
)
