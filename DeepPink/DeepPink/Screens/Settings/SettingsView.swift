//
//  SettingsView.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 30.01.2021.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - AppStorage

    @AppStorage("currentColor") var currentColor = AppColor.deeppink
    @AppStorage("addLabel") var addLabel = true
    @AppStorage("showAllFilters") var showAllFilters = false

    // MARK: - View
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Toggle(isOn: $addLabel, label: { Text("") })
                    .toggleStyle(RoundToggleStyle(color: currentColor.color,
                                                  imageName: "textformat"))
                    .frame(width: 100, height: 100, alignment: .center)
                Toggle(isOn: $showAllFilters, label: { Text("") })
                    .toggleStyle(RoundToggleStyle(color: currentColor.color,
                                                  imageName: "camera.filters"))
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
