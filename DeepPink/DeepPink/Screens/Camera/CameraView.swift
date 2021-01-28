//
//  CameraView.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct CameraView: View {

    // MARK: - EnvironmentObject

    @EnvironmentObject var viewRouter: ViewRouter

    // MARK: - AppStorage

    @AppStorage("currentColor") var currentColor = AppColor.deeppink

    // MARK: - Properties

    @State var didTapCapture: Bool = false
    @State var appeared: Bool = false
    @State var shown: Bool = false

    // MARK: - View

    var placeholder: some View {
        ZStack {
            currentColor.color
            Text(currentColor.name)
                .font(currentColor.font(size: 45))
                .foregroundColor(.black)
                .scaleEffect(appeared ? 1.5 : 1)
                .animation(.spring())
        }
    }

    var bottomView: some View {
        VStack {
            Spacer()
            ZStack {
                Button("") {
                    didTapCapture = true
                }
                .buttonStyle(TakePictureButtonStyle(color: currentColor.color))
                .frame(width: 80, height: 80)

                HStack {
                    Spacer()
                    Button("close") {
                        withAnimation {
                            viewRouter.currentPage = .main
                        }
                    }
                    .buttonStyle(CloseButtonStyle(color: currentColor.color))
                    .frame(width: 60, height: 60)
                    .padding(.horizontal, 25)
                }
            }
            .padding(.bottom, SafeArea.shared.bottom + 10)
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            if shown {
                CustomCameraRepresentable(didTapCapture: $didTapCapture)
                bottomView
            } else {
                placeholder
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            appeared = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeOut(duration: 1)) {
                    shown = true
                }
            }
        }
    }

}
