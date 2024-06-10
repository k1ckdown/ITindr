
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.coreFramework(
    name: "UserCoreData",
    hasResources: true,
    dependencies: [
        .project(target: "TopicDomain", path: "../../Domain/TopicDomain"),
        .project(target: "ProfileDomain", path: "../../Domain/ProfileDomain")
    ]
)
