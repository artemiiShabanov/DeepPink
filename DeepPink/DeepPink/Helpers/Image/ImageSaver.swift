//
//  ImageSaver.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 28.01.2021.
//

import UIKit

final class ImageSaver: NSObject {

    var onSuccess: EmptyClosure?
    var onError: Closure<Error>?

    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            onError?(error)
        } else {
            onSuccess?()
        }
    }

}
