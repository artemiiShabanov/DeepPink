//
//  AnyTransition+iris.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

extension AnyTransition {
    static var iris: AnyTransition {
        .modifier(
            active: ClipShapeModifier(shape: ScaledCircle(animatableData: 0)),
            identity: ClipShapeModifier(shape: ScaledCircle(animatableData: 1))
        )
    }
}
