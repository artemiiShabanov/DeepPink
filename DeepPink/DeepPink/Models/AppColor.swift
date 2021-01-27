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
            return "depppink"
        case .ashgrey:
            return "ashgrey"
        case .unmellow:
            return "unmellow"
        case .lime:
            return "lime"
        }
    }

    var font: Font {
        switch self {
        case .deeppink:
            return Font.system(.body)
        case .ashgrey:
            return Font.system(.body)
        case .unmellow:
            return Font.system(.body)
        case .lime:
            return Font.system(.body)
        }
    }

}
