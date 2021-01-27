//
//  MainView.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct MainView: View {

    // MARK: - EnvironmentObject

    @EnvironmentObject var viewRouter: ViewRouter

    // MARK: - AppStorage

    @AppStorage("currentColor") var currentColor = AppColor.deeppink

    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack(spacing: nil) {
                HStack {
                    Text(currentColor.name)
                        .font(currentColor.font(size: 35))
                        .foregroundColor(currentColor.color)
                        .rotationEffect(.init(degrees: 180), anchor: .center)
                        .rotationEffect(.init(degrees: 90), anchor: .leading)
                        .padding(.horizontal, 50)
                        .animation(.spring())
                    Spacer()
                }
                Spacer()
                ColorsView(colors: AppColor.allCases, currentColor: $currentColor)
                    .opacity(0.6)
                    .padding(.bottom, SafeArea.shared.bottom + 10)
            }
            Button("") {
                Feedback.haptic(.heavy)
            }
            .animation(.spring())
            .buttonStyle(OpenCameraButtonStyle(color: currentColor.color))
            .frame(width: 150, height: 150)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
