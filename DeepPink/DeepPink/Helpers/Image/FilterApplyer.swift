//
//  FilterApplyer.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 28.01.2021.
//

import UIKit
import CoreImage

struct FilterApplyer {

    public static let shared = FilterApplyer()

    private let context = CIContext()

    func apply(_ filter: CIFilter, to image: UIImage, size: CGSize? = nil) -> UIImage? {
        let resultSize = { () -> CGSize in
            if let size = size {
                return size
            } else {
                return image.size
            }
        }()

        let minScale = min(resultSize.width / image.size.width, resultSize.height / image.size.height)

        let ciInput = CIImage(image: image)?.transformed(by: .init(scaleX: minScale, y: minScale))
        filter.setValue(ciInput, forKey: kCIInputImageKey)

        guard
            let ciOutput = filter.outputImage,
            let cgImage = context.createCGImage(ciOutput, from: ciOutput.extent)
        else {
            return nil
        }
        return UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }

    func apply(_ filter: CIFilter, to image: CIImage) -> UIImage? {
        filter.setValue(image, forKey: kCIInputImageKey)
        guard
            let ciOutput = filter.outputImage,
            let cgImage = self.context.createCGImage(ciOutput, from: image.extent)
        else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }

}
