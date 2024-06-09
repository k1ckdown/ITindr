//
//  ProfileEditorScreen.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 23.05.2024.
//

import UDFKit
import SwiftUI
import CommonUI
import Kingfisher
import Navigation

typealias Strings = ProfileEditorStrings

struct ProfileEditorScreen: View, NavigationBarHidden {
    
    private(set) var isNavBarHidden: Bool
    @State private var selectedPhoto: PhotoDetails?
    @StateObject private var store: StoreOf<ProfileEditorReducer>
    
    init(isNavBarHidden: Bool, store: StoreOf<ProfileEditorReducer>) {
        self.isNavBarHidden = isNavBarHidden
        _store = StateObject(wrappedValue: store)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: .zero) {
                    HStack(spacing: .zero) {
                        avatarView
                        choosePhotoButton
                    }
                    
                    textFields
                    
                    TagLayout(store.state.topics, alignment: .leading) { model in
                        TopicView(model: model)
                            .onTapGesture {
                                store.dispatch(.topicTapped(model.id))
                            }
                    }
                    .screenTitle(Strings.chooseInterests)
                    .padding(.top, Constants.interestsInsetTop)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                Button(Strings.save) {
                    store.dispatch(.saveTapped)
                }
                .mainButtonStyle()
                .padding(.top, Constants.saveButtonInsetTop)
                .padding(.bottom)
            }
            .screenTitle(Strings.tellAboutYourself)
            .padding(.horizontal)
            .appLogo()
        }
        .onAppear {
            store.dispatch(.onAppear)
        }
        .sheet(isPresented: isPhotoPickerPresented) { photoPicker }
        .alert(Strings.selectSourceType, isPresented: isSourceTypeAlertPresented) {
            alertActions
        }
        .onChange(of: selectedPhoto) {
            guard
                let photo = $0,
                let data = photo.image.jpegData(compressionQuality: 0.5)
            else { return }
            
            store.dispatch(.avatarChosen(.init(data: data, fileName: photo.fileName)))
        }
    }
}

// MARK: - Views

private extension ProfileEditorScreen {
    
    var avatarView: some View {
        Group {
            if let selectedPhoto, store.state.isAvatarChosen {
                Image(uiImage: selectedPhoto.image)
                    .resizable()
            } else if let avatarUrl = store.state.avatarUrl {
                KFImage.url(URL(string: avatarUrl))
                    .placeholder { Images.avatarPlaceholder.swiftUIImage }
                    .resizable()
            } else {
                Images.avatarPlaceholder.swiftUIImage
            }
        }
        .frame(width: Constants.photoSize, height: Constants.photoSize)
        .clipShape(.circle)
    }
    
    var choosePhotoButton: some View {
        Button(store.state.hasAvatar ? Strings.deletePhoto : Strings.choosePhoto) {
            if store.state.hasAvatar {
                store.dispatch(.deletePhotoTapped)
            } else {
                store.dispatch(.choosePhotoTapped)
            }
        }
        .font(Fonts.bold16)
        .foregroundStyle(Colors.accentColor.swiftUIColor)
        .padding(.leading, Constants.choosePhotoInsetLeading)
    }
    
    var textFields: some View {
        VStack(spacing: .zero) {
            TextField(Strings.name, text: name)
                .mainTextFieldStyle()
                .submitLabel(.next)
                .textContentType(.username)
                .autocorrectionDisabled()
            
            // TODO: Placeholder
            TextEditor(text: aboutMyself)
                .tintColor()
                .font(Fonts.regular16)
                .transparentScrolling()
                .padding(.vertical, Constants.AboutMyself.insetVertical)
                .padding(.horizontal, Constants.AboutMyself.insetHorizontal)
                .frame(height: Constants.AboutMyself.height)
                .background(Colors.appLightGray.swiftUIColor)
                .clipShape(.rect(cornerRadius: Constants.AboutMyself.cornerRadius))
                .padding(.top)
                .submitLabel(.return)
        }
        .padding(.top)
    }
    
    @ViewBuilder
    var photoPicker: some View {
        switch store.state.photoSourceType {
        case .camera:
            CaptureImageView(photo: $selectedPhoto, isPresented: isPhotoPickerPresented)
        case .library:
            PhotoLibraryPicker(photo: $selectedPhoto, isPresented: isPhotoPickerPresented)
        case nil:
            EmptyView()
        }
    }
    
    @ViewBuilder
    var alertActions: some View {
        Button(Strings.camera) {
            store.dispatch(.sourceTypeSelected(.camera))
        }
        
        Button(Strings.photos) {
            store.dispatch(.sourceTypeSelected(.library))
        }
        
        Button(Strings.cancel, role: .cancel) {
            store.dispatch(.sourceTypeAlertPresented(false))
        }
    }
}

// MARK: - Bindings

private extension ProfileEditorScreen {
    
    var name: Binding<String> {
        Binding(store.state.name.content) {
            store.dispatch(.nameChanged($0))
        }
    }
    
    var aboutMyself: Binding<String> {
        Binding(store.state.aboutMyself ?? "") {
            store.dispatch(.aboutMyselfChanged($0))
        }
    }
    
    var isSourceTypeAlertPresented: Binding<Bool> {
        Binding(store.state.isSourceTypeAlertPresented) {
            store.dispatch(.sourceTypeAlertPresented($0))
        }
    }
    
    var isPhotoPickerPresented: Binding<Bool> {
        Binding(
            get: { store.state.isPhotoPickerPresented },
            set: { _ in store.dispatch(.sourceTypeSelected(nil)) }
        )
    }
}

// MARK: - Constants

private extension ProfileEditorScreen {
    
    enum Constants {
        static let photoSize: CGFloat = 88
        static let interestsInsetTop: CGFloat = 24
        static let saveButtonInsetTop: CGFloat = 55
        static let choosePhotoInsetLeading: CGFloat = 24
        
        enum AboutMyself {
            static let height: CGFloat = 128
            static let cornerRadius: CGFloat = 28
            static let insetVertical: CGFloat = 12
            static let insetHorizontal: CGFloat = 18
        }
    }
}
