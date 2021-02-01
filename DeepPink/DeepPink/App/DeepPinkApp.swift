//
//  DeepPinkApp.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

@main
struct DeepPinkApp: App {

    @StateObject var viewRouter = ViewRouter()
    var volumeListener = VolumeListener.shared

    var body: some Scene {
        WindowGroup {
            MotherView()
                .environmentObject(viewRouter)
                .statusBar(hidden: true)
                .onAppear(perform: {
                    volumeListener.start()
                })
        }
    }

}
