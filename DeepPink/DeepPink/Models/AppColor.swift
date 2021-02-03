//
//  AppColor.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI
import AVFoundation

enum AppColor: String, Identifiable, CaseIterable, RawRepresentable {

    // MARK: - Cases

    case deeppink
    case lavender
    case baby
    case blood

    // MARK: - Computed properties

    static var availableCases: [AppColor] {
        return [.deeppink, .lavender, .blood]
    }

    var id: String {
        return rawValue
    }

    var color: Color {
        switch self {
        case .deeppink:
            return Color.deeppink
        case .lavender:
            return Color.lavender
        case .baby:
            return Color.baby
        case .blood:
            return Color.blood
        }
    }

    var name: String {
        switch self {
        case .deeppink:
            return "deeppink"
        case .lavender:
            return "lavender"
        case .baby:
            return "baby blue"
        case .blood:
            return "blood"
        }
    }

    var sound: Feedback.Sound {
        switch self {
        case .deeppink:
            return .deeppink
        case .lavender:
            return .lavender
        case .baby:
            return .baby
        case .blood:
            return .blood
        }
    }

    func uiFont(size: CGFloat) -> UIFont {
        switch self {
        case .deeppink:
            return UIFont(name: "RetrofunkScriptPersonalUse", size: size) ?? UIFont.systemFont(ofSize: size)
        case .lavender:
            return UIFont(name: "SketsaRamadhan", size: size) ?? UIFont.systemFont(ofSize: size)
        case .baby:
            return UIFont(name: "OverScribble", size: size) ?? UIFont.systemFont(ofSize: size)
        case .blood:
            return UIFont(name: "YourDreamsDEMO-Brush", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }

    func font(size: CGFloat) -> Font {
        switch self {
        case .deeppink:
            return Font.custom("RetrofunkScriptPersonalUse", size: size)
        case .lavender:
            return Font.custom("SketsaRamadhan", size: size)
        case .baby:
            return Font.custom("OverScribble", size: size)
        case .blood:
            return Font.custom("YourDreamsDEMO-Brush", size: size)
        }
    }

}
