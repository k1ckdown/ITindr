
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "Profile",
    dependencies: [
        .project(target: "UDFKit", path: "../../Shared/Core/UDFKit"),
        .project(target: "CommonUI", path: "../../Shared/Core/CommonUI"),
        .project(target: "ProfileEditorInterface", path: "../ProfileEditor"),
        .project(target: "ProfileDomain", path: "../../Shared/Domain/ProfileDomain"),
    ]
)
