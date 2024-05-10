
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.coreFramework(
    name: "Network",
    dependencies: [
        .external(name: "Alamofire")
    ]
)
