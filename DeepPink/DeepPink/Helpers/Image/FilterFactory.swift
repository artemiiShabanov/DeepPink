//
//  FilterFactory.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 29.01.2021.
//

import CoreImage

enum FilterFactory {

    static func getFilter(for color: AppColor) -> CIFilter {
        switch color {
        case .ashgrey:
            return CIFilter(name: "CIPhotoEffectFade")!
        case .deeppink:
            return CIFilter(name: "CIPhotoEffectInstant")!
        case .unmellow:
            return CIFilter(name: "CIPhotoEffectMono")!
        case .lime:
            return CIFilter(name: "CIPhotoEffectNoir")!
        }
    }
    
}
