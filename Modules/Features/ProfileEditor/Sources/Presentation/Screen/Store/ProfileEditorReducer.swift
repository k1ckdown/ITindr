//
//  ProfileEditorReducer.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 24.05.2024.
//

import UDFKit
import CommonUI
import TopicDomain

struct ProfileEditorReducer: Reducer {

    func reduce(state: inout ProfileEditorState, intent: ProfileEditorIntent) {
        switch intent {
        case .saveTapped, .onAppear, .topicsLoadFailed: break
        case .topicTapped(let id):
            handleTopicTap(&state, id: id)
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
            handleTopicsLoad(&state, topics: topics)
        }
    }
}

// MARK: - Private methods

private extension ProfileEditorReducer {

    func handleTopicsLoad(_ state: inout ProfileEditorState, topics: [Topic]) {
        let topicViewModels = topics.map { topic in
            var topicViewModel = TopicView.Model(id: topic.id, title: topic.title)
            topicViewModel.isSelected = state.selectedTopicIds.contains(where: { $0 == topic.id })
            return topicViewModel
        }

        state.topics = topicViewModels
    }

    func handleTopicTap(_ state: inout ProfileEditorState, id: String) {
        guard let index = state.topics.firstIndex(where: { $0.id == id }) else { return }
        state.topics[index].isSelected.toggle()

        if let index = state.selectedTopicIds.firstIndex(of: id) {
            state.selectedTopicIds.remove(at: index)
        } else {
            state.selectedTopicIds.append(id)
        }
    }
}
