//
//  CloseButtonStyle.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct RoundButtonStyle: ButtonStyle {

    // MARK: - Properties

    let color: Color
    let imageName: String

    // MARK: - ButtonStyle

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.white).opacity(0.3)
            Image(systemName: imageName).font(.title2).foregroundColor(color)
        }
        .scaleEffect(configuration.isPressed ? 1.05 : 1)
        .opacity(configuration.isPressed ? 0.8 : 1)
    }
}
