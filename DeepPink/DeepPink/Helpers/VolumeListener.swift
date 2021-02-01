//
//  VolumeListener.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 30.01.2021.
//

import UIKit
import MediaPlayer

class VolumeListener {
    static let kVolumeKey = "volume"
    static let shared = VolumeListener()

    private let kAudioVolumeChangeReasonNotificationParameter = "AVSystemController_AudioVolumeChangeReasonNotificationParameter"
    private let kAudioVolumeNotificationParameter = "AVSystemController_AudioVolumeNotificationParameter"
    private let kExplicitVolumeChange = "ExplicitVolumeChange"
    private let kSystemVolumeDidChangeNotificationName = NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification")

    private var hasSetup = false

    func start() {
        guard !self.hasSetup else {
            return
        }

        self.setup()
        self.hasSetup = true

    }

    private func setup() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }

        let volumeView = MPVolumeView(frame: CGRect.zero)
        volumeView.clipsToBounds = true
        rootViewController.view.addSubview(volumeView)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.volumeChanged),
            name: kSystemVolumeDidChangeNotificationName,
            object: nil
        )

        volumeView.removeFromSuperview()
    }

    @objc func volumeChanged(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let volume = userInfo[kAudioVolumeNotificationParameter] as? Float,
            let changeReason = userInfo[kAudioVolumeChangeReasonNotificationParameter] as? String,
            changeReason == kExplicitVolumeChange
            else {
                return
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "volumeListenerUserDidInteractWithVolume"), object: nil,
                                        userInfo: [VolumeListener.kVolumeKey: volume])
    }
}
