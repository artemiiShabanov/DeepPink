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
            return FilterGroup(filters: [GrainFilter(), ScratchFilter()])
        case .ashgrey:
            return FilterGroup(filters: [GrainFilter(), ScratchFilter()])
        case .unmellow:
            return FilterGroup(filters: [GrainFilter(), ScratchFilter()])
        case .blood:
            return FilterGroup(filters: [
                                CIFilter(name: "CIPhotoEffectFade")!,
                                CIFilter(name: "CIPhotoEffectNoir")!,
                                GrainFilter()
            ])
        }
    }
    
}
