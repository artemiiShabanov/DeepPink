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

        guard
            let ciInput = CIImage(image: image)?.transformed(by: .init(scaleX: minScale, y: minScale)),
            let ciOutput = filter.apply(to: ciInput),
            let cgImage = context.createCGImage(ciOutput, from: ciOutput.extent)
        else {
            return nil
        }
        let imageWithoutLabel = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: image.imageOrientation)
        return addLabel ? TextToImageDrawer.addLabel(appColor: appColor, inImage: imageWithoutLabel, atPoint: .zero) : imageWithoutLabel
    }

    func apply(_ appColor: AppColor, to image: CIImage, addLabel: Bool = false) -> UIImage? {
        let filter = FilterFactory.getFilter(for: appColor)

        guard
            let ciOutput = filter.apply(to: image),
            let cgImage = self.context.createCGImage(ciOutput, from: image.extent)
        else {
            return nil
        }

        let imageWithoutLabel = UIImage(cgImage: cgImage)
        return addLabel ? TextToImageDrawer.addLabel(appColor: appColor, inImage: imageWithoutLabel, atPoint: .zero) : imageWithoutLabel
    }

    func emptyImage(_ appColor: AppColor, to image: CIImage) -> UIImage? {
        guard let cgImage = self.context.createCGImage(image, from: image.extent) else { return nil }

        let imageWithoutLabel = UIImage(color: .clear, size: CGSize(width: cgImage.width, height: cgImage.height)) ?? UIImage()
        return TextToImageDrawer.addLabel(appColor: appColor, inImage: imageWithoutLabel, atPoint: .zero) 
    }

}

enum TextToImageDrawer {

    static func addLabel(appColor: AppColor, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor(appColor.color)
        let textFont = appColor.uiFont(size: image.size.width / 10)

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center

        let textFontAttributes = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: style,
            .baselineOffset: 100.0

        ] as [NSAttributedString.Key : Any]

        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: CGPoint(x: 0, y: image.size.height / 2 - 30), size: image.size)
        appColor.name.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
