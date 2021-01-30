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
    @Binding var flash: Bool

    // MARK: - Properties

    let appColor: AppColor
    let addLabel: Bool
    private let imageSaver: ImageSaver = {
        let tmp = ImageSaver()
        tmp.onError = { _ in Feedback.shared.haptic(.rigid) }
        tmp.onSuccess = { Feedback.shared.haptic(.soft) }
        return tmp
    }()

    // MARK: - UIViewControllerRepresentable

    func makeUIViewController(context: Context) -> CustomCameraController {
        let controller = CustomCameraController(appColor: appColor, addLabel: addLabel)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ cameraViewController: CustomCameraController, context: Context) {
        if didTapCapture {
            cameraViewController.capture(flash: flash)
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

        func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
            AudioServicesDisposeSystemSoundID(1108)
            Feedback.shared.sound(parent.appColor.sound)
        }
    }

}

// MARK: - Private Methods

private extension CustomCameraRepresentable {

    func saveImage(_ image: UIImage) {
        if let filteredImage = FilterApplyer.shared.apply(appColor, to: image, addLabel: addLabel) {
            imageSaver.save(image: filteredImage)
        }
    }

}
