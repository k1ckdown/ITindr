
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureFramework(
    name: "MainTabBar",
    dependencies: [
        .project(target: "UserFeedInterface", path: "../UserFeed"),
        .project(target: "UserListInterface", path: "../UserList"),
        .project(target: "ChatListInterface", path: "../ChatList"),
        .project(target: "ProfileInterface", path: "../Profile"),
    ]
)
