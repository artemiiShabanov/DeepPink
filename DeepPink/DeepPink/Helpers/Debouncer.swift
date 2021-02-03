//
//  Debouncer.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 03.02.2021.
//

import Foundation

class Debouncer {

    // MARK: - Nested Types

    public typealias Handler = () -> Void

    // MARK: - Private Properties

    private let timeInterval: TimeInterval
    private var timer: Timer?

    // MARK: - Properties

    var handler: Handler?

    // MARK: - Initialization

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    // MARK: - Public Methods

    func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] (timer) in
            self?.timeIntervalDidFinish(for: timer)
        })
    }

    // MARK: - Private Actions

    @objc
    private func timeIntervalDidFinish(for timer: Timer) {
        guard timer.isValid else {
            return
        }

        handler?()
        handler = nil
    }

}
