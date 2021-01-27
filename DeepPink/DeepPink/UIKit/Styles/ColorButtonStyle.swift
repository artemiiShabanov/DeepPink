//
//  ColorButtonStyle.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct ColorButtonStyle: ButtonStyle {

    let color: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.init(white: 0.9))
            Circle()
                .foregroundColor(color)
                .scaleEffect(0.9)
        }
        .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
    }
}
