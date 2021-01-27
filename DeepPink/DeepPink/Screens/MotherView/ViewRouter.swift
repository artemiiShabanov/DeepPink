//
//  ViewRouter.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

enum Page {
    case main
    case camera
}

class ViewRouter: ObservableObject {

    @Published var currentPage: Page = .main

}
