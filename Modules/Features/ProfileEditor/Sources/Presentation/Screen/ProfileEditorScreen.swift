//
//  ProfileEditorScreen.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 23.05.2024.
//

import SwiftUI
import CommonUI
import UDFKit
import Kingfisher

typealias Strings = ProfileEditorStrings

struct ProfileEditorScreen: View {

    @State private var aboutMyself = Strings.aboutMyself
    @State private var selectedImage: ImageDetails?

    @State private var sourceType: PhotoSourceType?
    @State private var isSourceTypeAlertPresented = false

    @StateObject private var store: StoreOf<ProfileEditorReducer>

    init(store: StoreOf<ProfileEditorReducer>) {
        _store = StateObject(wrappedValue: store)
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: .zero) {
                HStack(spacing: .zero) {
                    photoView
                    choosePhotoButton
                }

                textFields

                VStack {
                    HStack {

                    }
                    .screenTitle(Strings.chooseInterests)
                }
                .padding(.top, Constants.interestsInsetTop)
            }
            .frame(maxHeight: .infinity, alignment: .top)

            Button(Strings.save) {

            }
            .mainButtonStyle()
            .padding(.bottom)
        }
        .screenTitle(Strings.tellAboutYourself)
        .padding(.horizontal)
        .appLogo()
        .sheet(isPresented: isPhotoPickerPresented) { photoPicker }
        .alert(Strings.selectSourceType, isPresented: $isSourceTypeAlertPresented) {
            alertActions
        }
    }
}

// MARK: - Views

private extension ProfileEditorScreen {

    var photoView: some View {
        Group {
            if let selectedImage {
                Image(uiImage: selectedImage.image)
                    .resizable()
            } else {
                KFImage.url(URL(string: "http://itindr.mcenter.pro:8092/static/avatar_b4f7ab2c-a3a0-46c0-bb27-1072fb903ec9.jpeg"))
                    .placeholder { Images.avatarPlaceholder.swiftUIImage }
                    .resizable()
            }
        }
        .frame(width: Constants.photoSize, height: Constants.photoSize)
        .clipShape(.circle)
    }

    var choosePhotoButton: some View {
        Button(selectedImage == nil ? Strings.choosePhoto : Strings.deletePhoto) {
            if selectedImage == nil {
                isSourceTypeAlertPresented = true
            } else {
                selectedImage = nil
            }
        }
        .font(Fonts.bold16)
        .foregroundStyle(Colors.accentColor.swiftUIColor)
        .padding(.leading, Constants.choosePhotoInsetLeading)
    }

    var textFields: some View {
        VStack(spacing: .zero) {
            TextField(Strings.name, text: .constant(""))
                .mainTextFieldStyle()
                .submitLabel(.next)
                .textContentType(.username)
                .autocorrectionDisabled()

            TextEditor(text: $aboutMyself)
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
        switch sourceType {
        case .camera:
            CaptureImageView(image: $selectedImage, isPresented: isPhotoPickerPresented)
        case .library:
            PhotoLibraryPicker(image: $selectedImage, isPresented: isPhotoPickerPresented)
        case nil:
            EmptyView()
        }
    }

    @ViewBuilder
    var alertActions: some View {
        Button(Strings.camera) {
            sourceType = .camera
        }

        Button(Strings.photos) {
            sourceType = .library
        }

        Button(Strings.cancel, role: .cancel) {
            isSourceTypeAlertPresented = false
        }
    }
}

// MARK: - Constants

private extension ProfileEditorScreen {

    enum Constants {
        static let photoSize: CGFloat = 88
        static let interestsInsetTop: CGFloat = 24
        static let choosePhotoInsetLeading: CGFloat = 24

        enum AboutMyself {
            static let height: CGFloat = 128
            static let cornerRadius: CGFloat = 28
            static let insetVertical: CGFloat = 12
            static let insetHorizontal: CGFloat = 18
        }
    }
}

// MARK: - Bindings

private extension ProfileEditorScreen {

    var isPhotoPickerPresented: Binding<Bool> {
        Binding(
            get: { sourceType != nil },
            set: { _ in sourceType = nil }
        )
    }
}
