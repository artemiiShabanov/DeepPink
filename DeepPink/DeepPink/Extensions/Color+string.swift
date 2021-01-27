//
//  Color+string.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import SwiftUI

extension Color {

    func toRGBAString() -> String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return "\(red),\(green),\(blue),\(alpha)"
    }

    init(RGBAString: String) {
        let array = RGBAString.components(separatedBy: ",")
        if
            let red = Double(array[0]),
            let green = Double(array[1]),
            let blue = Double(array[2]),
            let opacity = Double(array[3])
        {
            self.init(red: red, green: green, blue: blue, opacity: opacity)
        } else {
            self.init(white: 0)
        }
    }

}
