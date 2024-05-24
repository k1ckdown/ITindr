//
//  ProfileEditorState.swift
//  ProfileEditorInterface
//
//  Created by Ivan Semenov on 23.05.2024.
//

import CommonUI
import Foundation

enum PhotoSourceType {
    case camera
    case library
}

struct ProfileEditorState: Equatable {
    var name = TextFieldState()
    var aboutMyself = ""
    var photoUrl: String?
    var chosenPhoto: Data?
    var photoSourceType: PhotoSourceType?
    var isSourceTypeAlertPresented = false

    var isPhotoChosen: Bool {
        photoUrl != nil && chosenPhoto != nil
    }

    var isPhotoPickerPresented: Bool {
        photoSourceType != nil
    }
}

enum ProfileEditorIntent: Equatable {
    case saveTapped
    case choosePhotoTapped
    case deletePhotoTapped
    case photoChosen(Data)
    case nameChanged(String)
    case aboutMyselfChanged(String)
    case sourceTypeSelected(PhotoSourceType?)
}
