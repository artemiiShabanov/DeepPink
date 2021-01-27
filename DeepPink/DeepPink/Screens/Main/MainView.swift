//
//  MainView.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

struct MainView: View {

    // MARK: - AppStorage

    @AppStorage("currentColor") var currentColor = AppColor.deeppink
    @State private var isShowingRed = false
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)

                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 300, height: 300)
                        .transition(.iris)
                        .zIndex(1)
                }
            }
            .navigationBarItems(trailing: Button("Switch") {
                withAnimation(.easeInOut) {
                    self.isShowingRed.toggle()
                }
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
