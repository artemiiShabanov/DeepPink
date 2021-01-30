//
//  MainView.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI
import PhotosUI

struct MainView: View {

    // MARK: - Nested Types

    private enum AlertType: String, Identifiable {
        var id: String { return rawValue }
        case takePermissionDenied
        case savePermissionDenied
    }

    // MARK: - EnvironmentObject

    @EnvironmentObject var viewRouter: ViewRouter

    // MARK: - AppStorage

    @AppStorage("currentColor") var currentColor = AppColor.deeppink
    @AppStorage("showAllFilters") var showAllFilters = false

    // MARK: - State

    @State private var showSettings = false
    @State private var alert: AlertType?

    // MARK: - View

    var takePermissionDeniedAlert: Alert = {
        return Alert(title: Text("I need access to take pictures. You can give it in app settings"),
                     primaryButton: Alert.Button.default(Text("Settings"),
                                                         action: { SystemSegues.appSettings.open() }),
                     secondaryButton: Alert.Button.cancel())
    }()

    var savePermissionDeniedAlert: Alert = {
        return Alert(title: Text("I need access to save pictures to your library. You can give it in app settings"),
                     primaryButton: Alert.Button.default(Text("Settings"),
                                                         action: { SystemSegues.appSettings.open() }),
                     secondaryButton: Alert.Button.cancel())
    }()
    
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
                        .onTapGesture(count: 5, perform: {
                            showSettings = true
                        })
                    Spacer()
                }
                Spacer()
                ColorsView(colors: showAllFilters ? AppColor.allCases : AppColor.availableCases,
                           currentColor: $currentColor)
                    .opacity(0.6)
                    .padding(.bottom, SafeArea.shared.bottom + 10)
            }
            Button("") {
                Feedback.shared.haptic(.heavy)
                checkAccess() { resulf in
                    DispatchQueue.main.async {
                        switch resulf {
                        case .all:
                            withAnimation {
                                self.viewRouter.currentPage = .camera
                            }
                        case .noTake:
                            self.alert = .takePermissionDenied
                        case .noSave:
                            self.alert = .savePermissionDenied
                        }
                    }
                }
            }
            .animation(.spring())
            .buttonStyle(CameraButtonStyle(color: currentColor.color))
            .frame(width: 150, height: 150)
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .alert(item: $alert) {
            switch $0 {
            case .takePermissionDenied:
                return takePermissionDeniedAlert
            case .savePermissionDenied:
                return savePermissionDeniedAlert
            }
        }
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
    }
}

// MARK: - Private Methods

private extension MainView {

    enum CheckAccessResult {
        case all
        case noTake
        case noSave
    }

    func checkAccess(completion: @escaping Closure<CheckAccessResult>) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                checkSaveAccess() {
                    completion($0 ? .all : .noSave)
                }
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        checkSaveAccess() {
                            completion($0 ? .all : .noSave)
                        }
                    }
                }
            case .denied:
                completion(.noTake)
            case .restricted:
                completion(.noTake)
            @unknown default:
                completion(.noTake)
        }
    }

    func checkSaveAccess(completion: @escaping Closure<Bool>) {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            if status == .authorized {
                completion(true)
            } else {
                completion(false)
            }
        }
    }


}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
