//
//  ColorsView.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct ColorsView: View {

    // MARK: - Propeties

    let colors: [AppColor]
    @Binding var currentColor: AppColor

    // MARK: - View

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                Spacer(minLength: 20)
                ForEach(colors) { color in
                    Button("") {
                        Feedback.haptic(.heavy)
                        currentColor = color
                    }
                    .frame(width: 50, height: 50)
                    .animation(.easeInOut)
                    .buttonStyle(ColorButtonStyle(color: color.color))
                }
                Spacer(minLength: 20)
            }
            .frame(height: 100, alignment: .center)
        }
    }
}

struct ColorsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorsView(colors: AppColor.allCases, currentColor: .constant(.deeppink))
    }
}
