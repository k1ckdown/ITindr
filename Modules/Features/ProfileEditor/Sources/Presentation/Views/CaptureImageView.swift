//
//  CaptureImageView.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 23.05.2024.
//

import SwiftUI

struct CaptureImageView: UIViewControllerRepresentable {

    @Binding var image: ImageDetails?
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()

        pickerController.delegate = context.coordinator
        pickerController.sourceType = .camera

        return pickerController
    }

    func updateUIViewController(_ viewController: UIImagePickerController, context: Context) {}
}

// MARK: - Coordinator

extension CaptureImageView {

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        private let parent: CaptureImageView

        init(_ parent: CaptureImageView) {
            self.parent = parent
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.isPresented = false

            guard
                let fileName = info[.imageURL] as? URL,
                let image = info[.originalImage] as? UIImage,
                let imageData = image.jpegData(compressionQuality: 0.5)
            else { return }

            parent.image = ImageDetails(image: image, fileName: fileName.lastPathComponent)
        }
    }
}
