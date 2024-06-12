//
//  ProfileEditorConfig.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 12.06.2024.
//

import Navigation

public struct ProfileEditorConfig {
    public let profile: Profile
    public let screenTitle: String
    public let interestsHeader: String
    public let navigationTitle: String?
    public let isNavigationBarHidden: Bool
    public let flowFinishHandler: (() -> Void)?
    public let navigationController: NavigationController

    public init(
        profile: Profile,
        screenTitle: String,
        interestsHeader: String,
        navigationTitle: String? = nil,
        flowFinishHandler: (() -> Void)? = nil,
        navigationController: NavigationController
    ) {
        self.profile = profile
        self.screenTitle = screenTitle
        self.navigationTitle = navigationTitle
        self.interestsHeader = interestsHeader
        self.flowFinishHandler = flowFinishHandler
        self.navigationController = navigationController
        self.isNavigationBarHidden = navigationTitle == nil
    }
}
