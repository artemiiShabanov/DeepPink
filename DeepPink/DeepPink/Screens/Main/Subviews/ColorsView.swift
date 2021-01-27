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
//        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                Spacer(minLength: 20)
                ForEach(colors) { color in
                    Button("") {
                        Feedback.haptic(.light)
                        currentColor = color
                    }
                    .frame(width: 40, height: 40)
                    .animation(.spring())
                    .buttonStyle(ColorButtonStyle(color: color.color))
                }
                Spacer(minLength: 20)
            }
            .frame(height: 60, alignment: .center)
//        }
    }
}

struct ColorsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorsView(colors: AppColor.allCases, currentColor: .constant(.deeppink))
    }
}
