//
//  ProfileEditorState.swift
//  ProfileEditorInterface
//
//  Created by Ivan Semenov on 23.05.2024.
//

import CommonUI
import Foundation
import ProfileDomain

struct ProfileEditorState: Equatable {
    var name = TextFieldState()
    var aboutMyself = ""
    var avatarUrl: String?
    var chosenAvatar: Resource?
    var photoSourceType: PhotoSourceType?
    var isSourceTypeAlertPresented = false

    var isAvatarChosen: Bool {
        chosenAvatar != nil
    }

    var isPhotoPickerPresented: Bool {
        photoSourceType != nil
    }

    var hasAvatar: Bool {
        avatarUrl != nil && chosenAvatar != nil
    }
}

enum ProfileEditorIntent: Equatable {
    case saveTapped
    case choosePhotoTapped
    case deletePhotoTapped
    case avatarChosen(Resource)
    case nameChanged(String)
    case aboutMyselfChanged(String)
    case sourceTypeAlertPresented(Bool)
    case sourceTypeSelected(PhotoSourceType?)
}
