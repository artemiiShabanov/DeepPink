//
//  FilterFactory.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 29.01.2021.
//

import CoreImage
import UIKit

enum FilterFactory {

    static func getFilter(for color: AppColor) -> SimpleFilter {
        switch color {
        case .deeppink:
            return FilterGroup(filters: [
                CIFilter(name: "CIColorClamp",
                         parameters: ["inputMinComponents": CIVector(x: 0.07, y: 0.07, z: 0.07, w: 0.07),
                                      "inputMaxComponents": CIVector(x: 0.95, y: 0.95, z: 0.95, w: 0.95)])!,
                CIFilter(name: "CIPhotoEffectNoir")!,
                GrainFilter(),
                CIFilter(name: "CIColorMonochrome",
                         parameters: ["inputColor": CIColor(cgColor: UIColor(color.color).cgColor),
                                      "inputIntensity": 0.2])!,
            ])
        case .lavender:
            return FilterGroup(filters: [
                CIFilter(name: "CIPhotoEffectNoir")!,
                CIFilter(name: "CIColorControls",
                         parameters: ["inputContrast": NSNumber(0.8)])!,
                GrainFilter(),
                CIFilter(name: "CIColorMonochrome",
                         parameters: ["inputColor": CIColor(cgColor: UIColor(color.color).cgColor),
                                      "inputIntensity": 0.6])!,
            ])
        case .baby:
            return FilterGroup(filters: [
                CIFilter(name: "CIColorClamp",
                         parameters: ["inputMinComponents": CIVector(x: 0.07, y: 0.07, z: 0.07, w: 0.07),
                                      "inputMaxComponents": CIVector(x: 0.95, y: 0.95, z: 0.95, w: 0.95)])!,
                CIFilter(name: "CIColorMonochrome",
                         parameters: ["inputColor": CIColor(cgColor: UIColor.gray.cgColor),
                                      "inputIntensity": 0.95])!,
                GrainFilter()
            ])
        case .blood:
            return FilterGroup(filters: [
                FaceFilter(),
                CIFilter(name: "CIPhotoEffectNoir")!,
                CIFilter(name: "CIPhotoEffectNoir")!,
                GrainFilter()
            ])
        }
    }
    
}
