//
//  TakePictureButtonStyle.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct TakePictureButtonStyle: ButtonStyle {

    // MARK: - Properties

    let color: Color

    // MARK: - ButtonStyle

    private var overlay: some View {
        Circle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
            .hueRotation(.degrees(5))
            .scaleEffect(1.15)
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        Circle()
            .foregroundColor(color)
            .overlay(
                overlay
                    .foregroundColor(color)
                    .scaleEffect(configuration.isPressed ? 1.05 : 1)
                    .animation(.easeInOut)
            )

    }
}
