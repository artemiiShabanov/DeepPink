//
//  AppColor.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

enum AppColor: String, Identifiable, CaseIterable, RawRepresentable {

    // MARK: - Cases

    case deeppink
    case ashgrey
    case unmellow
    case lime

    // MARK: - Computed properties

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
        case .lime:
            return Color.lime
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
        case .lime:
            return "lime"
        }
    }

    func uiFont(size: CGFloat) -> UIFont {
        switch self {
        case .deeppink:
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
            }
            return UIFont(name: "PolandcannedintoFuture", size: size) ?? UIFont.systemFont(ofSize: size)
        case .ashgrey:
            return UIFont.systemFont(ofSize: size)
        case .unmellow:
            return UIFont.systemFont(ofSize: size)
        case .lime:
            return UIFont.systemFont(ofSize: size)
        }
    }

    func font(size: CGFloat) -> Font {
        switch self {
        case .deeppink:
            return Font.custom("deep", size: size)
        case .ashgrey:
            return Font.custom("deep", size: size)
        case .unmellow:
            return Font.custom("deep", size: size)
        case .lime:
            return Font.custom("deep", size: size)
        }
    }

}
