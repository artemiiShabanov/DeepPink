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
        let whitenVector = CIVector(x: -0.5, y: 0.5)
        let fineGrain = CIVector.random(range: CGFloat(0.0004)...CGFloat(0.0004))
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
        guard
            let blur = CIFilter(name: "CIGaussianBlur", parameters: [
                kCIInputImageKey: speckledImage,
                "inputRadius": 0.1
            ]),
            let bluredNoise = blur.outputImage
        else {
            return nil
        }
        return bluredNoise
    }

}

struct ScratchFilter: SimpleFilter {

    func apply(to ciimage: CIImage) -> CIImage? {
        let verticalScale = CGAffineTransform(scaleX: 1.5, y: 25)
        let transformedNoise = ciimage.transformed(by: verticalScale)
        let darkenVector = CIVector(x: 4, y: 0, z: 0, w: 0)
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

struct FaceFilter: SimpleFilter {

    func apply(to ciimage: CIImage) -> CIImage? {
        guard
            let pixelFilter = CIFilter(name:"CIPixellate", parameters: [
                kCIInputImageKey: ciimage,
                "inputScale": 30
            ]),
            let pixeleted = pixelFilter.outputImage
            else {
                return nil
        }
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let faceArray = detector?.features(in: ciimage, options: nil) ?? []

        guard !faceArray.isEmpty else {
            return nil
        }

        var maskImage: CIImage? = nil

        for f in faceArray {
            let centerX = (f.bounds.origin.x) + (f.bounds.size.width) / 2.0
            let centerY = (f.bounds.origin.y) + (f.bounds.size.height) / 2.0
            let radius: CGFloat = CGFloat(Double(min(f.bounds.size.width, f.bounds.size.height)) / 1.5)
            guard
                let radialGradient = CIFilter( name: "CIRadialGradient", parameters: [
                    "inputRadius0": NSNumber(value: Float(radius)),
                    "inputRadius1": NSNumber(value: Float(radius + 1.0)),
                    "inputColor0": CIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0),
                    "inputColor1": CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0),
                    kCIInputCenterKey: CIVector(x: centerX, y: centerY)
                ])
            else {
                continue
            }

            guard let circleImage = radialGradient.value(forKey: kCIOutputImageKey) as? CIImage else { continue }
            if let unwrappedMaskImage = maskImage {
                maskImage = CIFilter(name: "CISourceOverCompositing", parameters: [
                    kCIInputImageKey: circleImage,
                    kCIInputBackgroundImageKey: unwrappedMaskImage
                ])?.value(forKey: kCIOutputImageKey) as? CIImage
            } else {
                maskImage = circleImage
            }
        }

        guard
            let unwrappedMaskImage = maskImage,
            let filter = CIFilter(name:"CIBlendWithMask", parameters: [
                kCIInputImageKey: pixeleted,
                "inputBackgroundImage": ciimage,
                "inputMaskImage": unwrappedMaskImage
            ]),
            let image = filter.outputImage
        else {
            return nil
        }
        return image
    }


}
