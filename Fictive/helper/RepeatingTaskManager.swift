//
//  ReapetingTaskManager.swift
//  Fictive
//
//  Created by Prof Ahyox on 29/11/2020.
//

import Foundation

class RepeatingTaskManager {
    let timeInterval: TimeInterval
        
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
        
    private lazy var timer: DispatchSourceTimer = {
        let timerSource = DispatchSource.makeTimerSource()
        timerSource.schedule(deadline: .now() + .seconds(1), repeating: self.timeInterval)
        
        timerSource.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        
        return timerSource
    }()

    var eventHandler: (() -> Void)?

    private enum State {
        case suspended
        case resumed
    }

    private var state: State = .suspended

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
        eventHandler = nil
    }

    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
}
