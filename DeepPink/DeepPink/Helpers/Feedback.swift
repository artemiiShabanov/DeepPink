//
//  Feedback.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import UIKit

enum Feedback {

    static func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    static func sound() { }

}
