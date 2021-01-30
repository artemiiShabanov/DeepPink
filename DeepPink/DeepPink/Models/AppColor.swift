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
    case ashgrey
    case unmellow
    case blood

    // MARK: - Computed properties

    static var availableCases: [AppColor] {
        return [.deeppink, .blood]
    }

    var id: String {
        return rawValue
    }

    var color: Color {
        switch self {
        case .deeppink:
            return Color.deeppink
        case .ashgrey:
            return Color.ashgrey
        case .unmellow:
            return Color.unmellow
        case .blood:
            return Color.blood
        }
    }

    var name: String {
        switch self {
        case .deeppink:
            return "deeppink"
        case .ashgrey:
            return "ashgrey"
        case .unmellow:
            return "unmellow"
        case .blood:
            return "blood"
        }
    }

    var sound: Feedback.Sound {
        switch self {
        case .deeppink:
            return .deeppink
        case .ashgrey:
            return .ashgrey
        case .unmellow:
            return .unmellow
        case .blood:
            return .blood
        }
    }

    func uiFont(size: CGFloat) -> UIFont {
        switch self {
        case .deeppink:
            return UIFont(name: "RetrofunkScriptPersonalUse", size: size) ?? UIFont.systemFont(ofSize: size)
        case .ashgrey:
            return UIFont(name: "SketsaRamadhan", size: size) ?? UIFont.systemFont(ofSize: size)
        case .unmellow:
            return UIFont(name: "OverScribble", size: size) ?? UIFont.systemFont(ofSize: size)
        case .blood:
            return UIFont(name: "YourDreamsDEMO-Brush", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }

    func font(size: CGFloat) -> Font {
        switch self {
        case .deeppink:
            return Font.custom("RetrofunkScriptPersonalUse", size: size)
        case .ashgrey:
            return Font.custom("SketsaRamadhan", size: size)
        case .unmellow:
            return Font.custom("OverScribble", size: size)
        case .blood:
            return Font.custom("YourDreamsDEMO-Brush", size: size)
        }
    }

}
