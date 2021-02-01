//
//  FilterFactory.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 29.01.2021.
//

import CoreImage

enum FilterFactory {

    static func getFilter(for color: AppColor) -> SimpleFilter {
        switch color {
        case .deeppink:
            return FilterGroup(filters: [
                CIFilter(name: "CIColorClamp",
                         parameters: ["inputMinComponents": CIVector(x: 0.1, y: 0.1, z: 0.1, w: 0.1),
                                      "inputMaxComponents": CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9)])!,
                CIFilter(name: "CIPhotoEffectNoir")!,
                GrainFilter(),
                CIFilter(name: "CIColorMonochrome",
                         parameters: ["inputColor": CIColor(red: 255, green: 20 / 255, blue: 147 / 255),
                                      "inputIntensity": 0.1])!,
            ])
        case .ashgrey:
            return FilterGroup(filters: [
                FaceFilter(),
                CIFilter(name: "CIColorClamp",
                         parameters: ["inputMinComponents": CIVector(x: 0.1, y: 0.1, z: 0.1, w: 0.1),
                                      "inputMaxComponents": CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9)])!,
                CIFilter(name: "CISepiaTone", parameters: ["inputIntensity": 0.5])!,
                GrainFilter()
            ])
        case .unmellow:
            return FilterGroup(filters: [
                CIFilter(name: "CIPhotoEffectTonal")!,
                CIFilter(name: "CIColorMonochrome",
                         parameters: ["inputColor": CIColor(red: 0, green: 90 / 255, blue: 200 / 255),
                                      "inputIntensity": 0.3])!,
                GrainFilter()
            ])
        case .blood:
            return FilterGroup(filters: [
                CIFilter(name: "CIPhotoEffectNoir")!,
                CIFilter(name: "CIPhotoEffectNoir")!
            ])
        }
    }
    
}
