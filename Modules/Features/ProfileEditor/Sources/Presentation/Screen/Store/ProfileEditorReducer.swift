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
        case .saveTapped, .onAppear, .topicsLoadFailed: break
        case .topicTapped(let id):
            guard let index = state.topics.firstIndex(where: { $0.id == id }) else { return }
            state.topics[index].isSelected.toggle()
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
        case .topicsLoaded(let topics):
            state.topics = topics.map { .init(id: $0.id, title: $0.title) }
        }
    }
}
