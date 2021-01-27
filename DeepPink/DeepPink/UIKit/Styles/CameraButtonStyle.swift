//
//  OpenCameraButtonStyle.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct CameraButtonStyle: ButtonStyle {

    // MARK: - Properties

    let color: Color

    // MARK: - ButtonStyle

    private var overlay: some View {
        Circle()
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [15]))
            .hueRotation(.degrees(5))
            .scaleEffect(1.05)
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .overlay(
                    overlay
                        .foregroundColor(color)
                        .rotationEffect(configuration.isPressed ? Angle(degrees: 180) : .zero)
                )
            Image(systemName: "camera.fill")
                .font(.largeTitle)
                .foregroundColor(.black)
        }
        .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}
