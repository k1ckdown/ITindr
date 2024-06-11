//
//  ProfileEditorState.swift
//  ProfileEditorInterface
//
//  Created by Ivan Semenov on 23.05.2024.
//

import Foundation
import CommonUI
import CommonDomain
import TopicDomain
import ProfileDomain

struct ProfileEditorState: Equatable {
    var name = TextFieldState()
    var aboutMyself: String?
    var avatarUrl: String?
    var avatarData: Data?
    var chosenAvatar: Resource?
    var topics = [TopicView.Model]()
    var selectedTopicIds = [String]()
    var photoSourceType: PhotoSourceType?
    var isSourceTypeAlertPresented = false
    
    var isAvatarChosen: Bool { chosenAvatar != nil }
    var isSaveEnabled: Bool { name.content.isEmpty == false }
    var isPhotoPickerPresented: Bool { photoSourceType != nil }
    
    var hasAvatar: Bool {
        avatarData != nil || chosenAvatar != nil
    }
}

enum ProfileEditorIntent: Equatable {
    case onAppear
    case saveTapped
    case choosePhotoTapped
    case deletePhotoTapped
    case topicTapped(String)
    case topicsLoaded([Topic])
    case topicsLoadFailed(String)
    case avatarChosen(Resource)
    case nameChanged(String)
    case aboutMyselfChanged(String)
    case sourceTypeAlertPresented(Bool)
    case sourceTypeSelected(PhotoSourceType?)
}
