//
//  CustomCameraRepresentable.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 28.01.2021.
//

import SwiftUI
import AVFoundation

struct CustomCameraRepresentable: UIViewControllerRepresentable {

    // MARK: - Binding

    @Binding var didTapCapture: Bool

    // MARK: - Properties

    private let imageSaver: ImageSaver = {
        let tmp = ImageSaver()
        tmp.onError = { _ in }
        tmp.onSuccess = { }
        return tmp
    }()

    // MARK: - UIViewControllerRepresentable

    func makeUIViewController(context: Context) -> CustomCameraController {
        let controller = CustomCameraController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ cameraViewController: CustomCameraController, context: Context) {
        if self.didTapCapture {
            cameraViewController.didTapRecord()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
        let parent: CustomCameraRepresentable

        init(_ parent: CustomCameraRepresentable) {
            self.parent = parent
        }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            parent.didTapCapture = false
            if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) {
                parent.saveImage(image)
            }
        }
    }

}

// MARK: - Private Methods

private extension CustomCameraRepresentable {

    func saveImage(_ image: UIImage) {
        imageSaver.save(image: image)
    }

}
