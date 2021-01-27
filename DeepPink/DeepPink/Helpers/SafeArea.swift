//
//  SafeArea.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import UIKit

class SafeArea {
    static let shared = SafeArea()
    private let window = UIApplication.shared.windows.first
    private init() { }
    var top: CGFloat { window?.safeAreaInsets.top ?? 0 }
    var bottom: CGFloat { window?.safeAreaInsets.bottom ?? 0 }
}
