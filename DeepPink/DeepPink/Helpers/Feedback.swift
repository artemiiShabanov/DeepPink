//
//  Feedback.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 27.01.2021.
//

import UIKit
import AVFoundation

class Feedback {

    private init() { }
    static let shared = Feedback()
    private var player: AVAudioPlayer?

    enum Sound: String {
        case deeppink = "deeppink"
        case ashgrey = "ashgrey"
        case unmellow = "unmellow"
        case blood = "blood"
    }

    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    func sound(_ sound: Sound) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}
