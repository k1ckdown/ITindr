
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "ChatList",
    dependencies: [
        .external(name: "Kingfisher"),
        .project(target: "ChatInterface", path: "../Chat"),
        .project(target: "UDFKit", path: "../../Shared/Core/UDFKit"),
        .project(target: "CommonUI", path: "../../Shared/Core/CommonUI"),
        .project(target: "ChatDomain", path: "../../Shared/Domain/ChatDomain")
    ]
)
