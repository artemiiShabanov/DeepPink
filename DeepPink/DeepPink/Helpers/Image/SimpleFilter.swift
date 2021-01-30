//
//  CIFilterGroup.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 30.01.2021.
//

import CoreImage

protocol SimpleFilter {
    func apply(to ciimage: CIImage) -> CIImage?
}

struct FilterGroup: SimpleFilter {

    let filters: [SimpleFilter]

    func apply(to ciimage: CIImage) -> CIImage? {
        var image: CIImage = ciimage
        filters.forEach {
            if let filtered = $0.apply(to: image) {
                image = filtered
            }
        }
        return image.cropped(to: ciimage.extent)
    }
    
}

extension CIFilter: SimpleFilter {

    func apply(to ciimage: CIImage) -> CIImage? {
        setValue(ciimage, forKey: kCIInputImageKey)
        guard let image = outputImage else {
            return nil
        }
        return image
    }

}

struct GrainFilter: SimpleFilter {

    func apply(to ciimage: CIImage) -> CIImage? {
        guard
            let coloredNoise = CIFilter(name:"CIRandomGenerator"),
            let noiseImage = coloredNoise.outputImage
            else {
                return nil
        }
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x:0, y: 0.005, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        guard
            let whiteningFilter = CIFilter(name:"CIColorMatrix",
                                           parameters:
            [
                kCIInputImageKey: noiseImage,
                "inputRVector": whitenVector,
                "inputGVector": whitenVector,
                "inputBVector": whitenVector,
                "inputAVector": fineGrain,
                "inputBiasVector": zeroVector
            ]),
            let whiteSpecks = whiteningFilter.outputImage
            else {
                return nil
        }
        guard
            let speckCompositor = CIFilter(name:"CISourceOverCompositing",
                                           parameters:
            [
                kCIInputImageKey: whiteSpecks,
                kCIInputBackgroundImageKey: ciimage
            ]),
            let speckledImage = speckCompositor.outputImage
            else {
                return nil
        }
        return speckledImage
    }

}

struct ScratchFilter: SimpleFilter {

    func apply(to ciimage: CIImage) -> CIImage? {
        let verticalScale = CGAffineTransform(scaleX: 1.5, y: 25)
        let transformedNoise = ciimage.transformed(by: verticalScale)
        let darkenVector = CIVector(x: 5, y: 0, z: 0, w: 0)
        let darkenBias = CIVector(x: 0, y: 1, z: 1, w: 1)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)

        guard
            let darkeningFilter = CIFilter(name:"CIColorMatrix",
                                           parameters:
            [
                kCIInputImageKey: transformedNoise,
                "inputRVector": darkenVector,
                "inputGVector": zeroVector,
                "inputBVector": zeroVector,
                "inputAVector": zeroVector,
                "inputBiasVector": darkenBias
            ]),
            let randomScratches = darkeningFilter.outputImage
            else {
                return nil
        }
        guard
            let grayscaleFilter = CIFilter(name:"CIMinimumComponent",
                                           parameters:
            [
                kCIInputImageKey: randomScratches
            ]),
            let darkScratches = grayscaleFilter.outputImage
            else {
                return nil
        }
        guard
            let oldFilmCompositor = CIFilter(name:"CIMultiplyCompositing",
                                             parameters:
            [
                kCIInputImageKey: darkScratches,
                kCIInputBackgroundImageKey: ciimage
            ]),
            let oldFilmImage = oldFilmCompositor.outputImage
            else {
                return nil
        }
        return oldFilmImage
    }

}
