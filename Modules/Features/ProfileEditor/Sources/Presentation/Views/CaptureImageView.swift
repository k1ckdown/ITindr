//
//  CaptureImageView.swift
//  ProfileEditor
//
//  Created by Ivan Semenov on 23.05.2024.
//

import SwiftUI

struct CaptureImageView: UIViewControllerRepresentable {
    
    @Binding var photo: PhotoDetails?
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
                let imageUrl = info[.imageURL] as? URL,
                let image = info[.originalImage] as? UIImage
            else { return }
            
            parent.photo = PhotoDetails(image: image, fileName: imageUrl.lastPathComponent)
        }
    }
}
