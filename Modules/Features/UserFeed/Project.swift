
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "UserFeed",
    dependencies: [
        .external(name: "Kingfisher"),
        .project(target: "UserMatchInterface", path: "../UserMatch"),
        .project(target: "UDFKit", path: "../../Shared/Core/UDFKit"),
        .project(target: "CommonUI", path: "../../Shared/Core/CommonUI"),
        .project(target: "ProfileDomain", path: "../../Shared/Domain/ProfileDomain")
    ]
)
