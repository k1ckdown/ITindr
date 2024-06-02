//
//  ProfileEditorReducer.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit

struct ProfileEditorReducer: Reducer {

    func reduce(state: inout ProfileEditorState, intent: ProfileEditorIntent) {
        switch intent {
        case .saveTapped: break
        case .choosePhotoTapped:
            state.isSourceTypeAlertPresented = true
        case .deletePhotoTapped:
            state.avatarUrl = nil
            state.chosenAvatar = nil
        case .avatarChosen(let avatar):
            state.chosenAvatar = avatar
        case .nameChanged(let name):
            state.name.content = name
        case .aboutMyselfChanged(let aboutMyself):
            state.aboutMyself = aboutMyself
        case .sourceTypeSelected(let type):
            state.photoSourceType = type
        case .sourceTypeAlertPresented(let isPresented):
            state.isSourceTypeAlertPresented = isPresented
        }
    }
}
