//
//  CIVector+random.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 30.01.2021.
//

import CoreImage

extension CIVector {
    static func random(range: ClosedRange<CGFloat>) -> CIVector {
        return CIVector(x: CGFloat.random(in: range),
                        y: CGFloat.random(in: range),
                        z: CGFloat.random(in: range),
                        w: CGFloat.random(in: range))
    }
}
