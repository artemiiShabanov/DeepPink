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

    func apply(_ appColor: AppColor, to image: UIImage, size: CGSize? = nil, addLabel: Bool = false) -> UIImage? {
        let filter = FilterFactory.getFilter(for: appColor)
        
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
        let imageWithoutLabel = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: image.imageOrientation)
        return addLabel ? TextToImageDrawer.addLabel(appColor: appColor, inImage: imageWithoutLabel, atPoint: .zero) : imageWithoutLabel
    }

    func apply(_ appColor: AppColor, to image: CIImage) -> UIImage? {
        let filter = FilterFactory.getFilter(for: appColor)
        
        filter.setValue(image, forKey: kCIInputImageKey)
        guard
            let ciOutput = filter.outputImage,
            let cgImage = self.context.createCGImage(ciOutput, from: image.extent)
        else {
            return nil
        }

        return TextToImageDrawer.addLabel(appColor: appColor, inImage: UIImage(cgImage: cgImage), atPoint: .zero)
    }

}

enum TextToImageDrawer {

    static func addLabel(appColor: AppColor, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor(appColor.color)
        let textFont = appColor.uiFont(size: image.size.width / 10)

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        appColor.name.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
