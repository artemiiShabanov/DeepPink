//
//  FlashToggleStyle.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 30.01.2021.
//

import SwiftUI

struct FlashToggleStyle: ToggleStyle {

    // MARK: - Properties

    let color: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .opacity(configuration.isOn ? 0.3 : 0.05)
            Circle()
                .strokeBorder(lineWidth: 2)
                .foregroundColor(.white)
                .opacity(0.3)
            Image(systemName: configuration.isOn ? "flashlight.on.fill" : "flashlight.off.fill").font(.title2).foregroundColor(color)
        }.onTapGesture {
            configuration.isOn.toggle()
        }
    }

}
