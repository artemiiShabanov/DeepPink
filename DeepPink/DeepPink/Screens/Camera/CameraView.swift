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
    @AppStorage("addLabel") var addLabel = true

    // MARK: - State

    @StateObject private var cameraViewModel = CameraViewModel()
    @State var appeared: Bool = false
    @State var flash: Bool = false
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
            ZStack {
                HStack {
                    Spacer()
                    Button("") {
                        withAnimation {
                            viewRouter.currentPage = .main
                        }
                    }
                    .buttonStyle(RoundButtonStyle(color: currentColor.color, imageName: "arrow.down.right.and.arrow.up.left"))
                    .frame(width: 60, height: 60)
                    .padding(.horizontal, 25)
                }
            }
            .padding(.top, SafeArea.shared.top + 10)

            Spacer()

            ZStack {
                Button("") {
                    cameraViewModel.didTapCapture = true
                }
                .buttonStyle(TakePictureButtonStyle(color: currentColor.color))
                .frame(width: 80, height: 80)


                HStack {
                    Button("") {
                        SystemSegues.gallery.open()
                    }
                    .buttonStyle(RoundButtonStyle(color: currentColor.color, imageName: "photo.on.rectangle"))
                    .frame(width: 60, height: 60)
                    .padding(.horizontal, 25)
                    Spacer()
                }

                HStack {
                    Spacer()
                    Toggle(isOn: $flash) { Text("Show welcome message") }
                        .toggleStyle(FlashToggleStyle(color: currentColor.color))
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
                CustomCameraRepresentable(didTapCapture: $cameraViewModel.didTapCapture, flash: $flash, appColor: currentColor, addLabel: addLabel)
                bottomView
            } else {
                placeholder
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
//            cameraViewModel.subscriveOnNotifications()
            appeared = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeOut(duration: 1)) {
                    shown = true
                }
            }
        }
    }

}

// MARK: - View Model

private class CameraViewModel: ObservableObject {

    @Published var didTapCapture: Bool = false

    func subscriveOnNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.userInteractedWithVolume),
                                               name: NSNotification.Name(rawValue: "volumeListenerUserDidInteractWithVolume"), object: nil)
    }

    @objc
    func userInteractedWithVolume() {
        didTapCapture = true
    }

}
