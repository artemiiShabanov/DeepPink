//
//  ClipShapeModifier.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct ClipShapeModifier<T: Shape>: ViewModifier {
    let shape: T

    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}
