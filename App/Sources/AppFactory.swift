//
//  AppFactory.swift
//  ITindr
//
//  Created by Ivan Semenov on 10.05.2024.
//

import Chat
import Auth
import Profile
import ChatList
import UserList
import UserFeed
import UserMatch
import ProfileEditor
import AuthFlow
import ProfileData
import AuthData
import UserData
import ChatData
import MainTabBar
import ChatDomain
import AuthDomain
import ProfileDomain
import Network
import Keychain
import Navigation

final class AppFactory {

    private lazy var authInterceptor = AuthInterceptor()
    private lazy var keychainStorage = KeychainStorage()
    private lazy var networkService = NetworkService(authInterceptor: authInterceptor)

    private lazy var chatRepository: ChatRepositoryProtocol = {
        let dependencies = ChatData.ModuleDependencies(
            userIdProvider: profileRepository.getUserId,
            networkService: networkService
        )

        return ChatRepositoryAssembly(dependencies: dependencies).assemble()
    }()

    private lazy var userRepository: UserRepositoryProtocol = {
        let dependencies = UserData.ModuleDependencies(networkService: networkService)
        return UserRepositoryAssembly(dependencies: dependencies).assemble()
    }()

    private lazy var profileRepository: ProfileRepositoryProtocol = {
        let dependencies = ProfileData.ModuleDependencies(networkService: networkService)
        return ProfileRepositoryAssembly(dependencies: dependencies).assemble()
    }()

    private lazy var authRepository: AuthRepositoryProtocol = {
        let repository = AuthRepository(
            networkService: networkService,
            credentialsLocalDataSource: keychainStorage
        )

        authInterceptor.delegate = repository
        return repository
    }()
}

// MARK: - Public methods

@MainActor
extension AppFactory {

    func makeAuthFlowCoordinatorAssembly() -> AuthFlowCoordinatorAssembly {
        let dependencies = AuthFlow.ModuleDependencies(
            authCoordinatorAssembly: makeAuthCoordinatorAssembly(),
            profileEditorCoordinatorAssembly: makeProfileEditorCoordinatorAssembly()
        )

        return AuthFlowCoordinatorAssembly(dependencies: dependencies)
    }

    func makeMainTabBarCoordinatorAssembly() -> MainTabBarCoordinatorAssembly {
        print(authRepository.isLoggedIn())
        let dependencies = MainTabBar.ModuleDependencies(
            profileCoordinatorAssembly: ProfileCoordinatorAssembly(),
            chatListCoordinatorAssembly: makeChatListCoordinatorAssembly(),
            userFeedCoordinatorAssembly: makeUserFeedCoordinatorAssembly(),
            userListCoordinatorAssembly: makeUserListCoordinatorAssembly()
        )

        return MainTabBarCoordinatorAssembly(dependencies: dependencies)
    }
}

// MARK: - Private methods

@MainActor
private extension AppFactory {

    func makeChatCoordinatorAssembly() -> ChatCoordinatorAssembly {
        ChatCoordinatorAssembly(dependencies: .init(chatRepository: chatRepository))
    }

    func makeUserListCoordinatorAssembly() -> UserListCoordinatorAssembly {
        let dependencies = UserList.ModuleDependencies(userRepository: userRepository)
        return UserListCoordinatorAssembly(dependencies: dependencies)
    }

    func makeUserMatchCoordinatorAssembly() -> UserMatchCoordinatorAssembly {
        let dependencies = UserMatch.ModuleDependencies(chatRepository: chatRepository)
        return UserMatchCoordinatorAssembly(dependencies: dependencies)
    }

    func makeAuthCoordinatorAssembly() -> AuthCoordinatorAssembly {
        let dependencies = Auth.ModuleDependencies(authRepository: authRepository)
        return AuthCoordinatorAssembly(dependencies: dependencies)
    }

    func makeProfileEditorCoordinatorAssembly() -> ProfileEditorCoordinatorAssembly {
        let dependencies = ProfileEditor.ModuleDependencies(profileRepository: profileRepository)
        return ProfileEditorCoordinatorAssembly(dependencies: dependencies)
    }

    func makeUserFeedCoordinatorAssembly() -> UserFeedCoordinatorAssembly {
        let dependencies = UserFeed.ModuleDependencies(
            userRepository: userRepository,
            userMatchCoordinatorAssembly: makeUserMatchCoordinatorAssembly()
        )

        return UserFeedCoordinatorAssembly(dependencies: dependencies)
    }

    func makeChatListCoordinatorAssembly() -> ChatListCoordinatorAssembly {
        let dependencies = ChatList.ModuleDependencies(
            chatRepository: chatRepository,
            chatCoordinatorAssembly: makeChatCoordinatorAssembly()
        )

        return ChatListCoordinatorAssembly(dependencies: dependencies)
    }
}
