//
//  SystemService.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 29.01.2021.
//

import UIKit

enum SystemSegues {
    case appSettings
    case gallery

    func open() {
        switch self {
        case .appSettings:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        case .gallery:
            UIApplication.shared.open(URL(string:"photos-redirect://")!)
        }
    }
}
