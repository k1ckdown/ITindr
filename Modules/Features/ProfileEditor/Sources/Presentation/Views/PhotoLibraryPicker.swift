//
//  File.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 23.05.2024.
//

import SwiftUI
import PhotosUI

struct ImageDetails {
    let image: UIImage
    let fileName: String
}

struct PhotoLibraryPicker: UIViewControllerRepresentable {

    @Binding var image: ImageDetails?
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.preferredAssetRepresentationMode = .current

        let viewController = PHPickerViewController(configuration: configuration)
        viewController.delegate = context.coordinator

        return viewController
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

// MARK: - Coordinator

extension PhotoLibraryPicker {

    final class Coordinator: NSObject, PHPickerViewControllerDelegate {

        private let parent: PhotoLibraryPicker

        init(_ parent: PhotoLibraryPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard
                let result = results.first,
                result.itemProvider.canLoadObject(ofClass: UIImage.self),
                let fileName = result.itemProvider.registeredTypeIdentifiers.first
            else {
                parent.isPresented = false
                return
            }

            result.itemProvider.loadObject(ofClass: UIImage.self) { item, error in
                DispatchQueue.main.async { [weak self] in
                    guard let image = item as? UIImage else { return }

                    self?.parent.image = ImageDetails(image: image, fileName: fileName)
                    self?.parent.isPresented = false
                }
            }
        }
    }
}
