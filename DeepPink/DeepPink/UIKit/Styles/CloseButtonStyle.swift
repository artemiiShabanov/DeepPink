//
//  CloseButtonStyle.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct CloseButtonStyle: ButtonStyle {

    // MARK: - Properties

    let color: Color

    // MARK: - ButtonStyle

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.white).opacity(0.6)
            Image(systemName: "arrow.down.right.and.arrow.up.left").font(.title2).foregroundColor(color)
        }.scaleEffect(configuration.isPressed ? 1.05 : 1)
    }
}
