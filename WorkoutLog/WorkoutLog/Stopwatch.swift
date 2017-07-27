//
//  Stopwatch.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 7/24/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation

protocol StopwatchDelegate {
    func currentStopwatchTime(elapsedTime:String)
}

enum StopwatchType {
    case CountUp
    case CountDown
}

class Stopwatch {
    
    public var type:StopwatchType?
    private var timer:Timer?
    private var pausedElapsedTime:TimeInterval?
    private var startTime:Date?
    var countDownTime:TimeInterval?
    var delegate:StopwatchDelegate?
    var elapsedTime:TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var elapsedTimeString:String {
        guard let typeSelected = self.type else {
            return "00:00:0"
        }
        switch typeSelected {
        case .CountUp:
            let minutes = Int(elapsedTime) / 60 % 60
            let seconds = Int(elapsedTime) % 60
            let ms = Int((elapsedTime * 10).truncatingRemainder(dividingBy: 10))
            return String(format:"%02i:%02i.%i",minutes, seconds, ms)
            
        case .CountDown:
            if (self.countDownTime != nil) {
                let timeLeft = self.countDownTime! - self.elapsedTime
                if !(timeLeft < 0) {
                    let minutesLeft = Int(timeLeft) / 60
                    let secondsLeft = Int(timeLeft) % 60
                    let ms = Int((timeLeft * 10).truncatingRemainder(dividingBy: 10))
                    return String(format:"%02i:%02i:%i", minutesLeft, secondsLeft, ms)
                } else {
                    self.stop()
                    return "00:00:0"
                }
            }
            return "00:00:0"
        }
    }
    
    var isRunning:Bool {
        return self.startTime != nil
    }
    
    func start() {
        self.startTime = Date()
        if self.delegate != nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.callDelegateMethod(_ :)), userInfo: nil, repeats: true)
        } else {
            
        }
    }
    
    @objc private func callDelegateMethod(_ timer:Timer) {
        if self.delegate != nil {
            self.delegate?.currentStopwatchTime(elapsedTime: self.elapsedTimeString)
        } else {
            timer.invalidate()
        }
    }
    
    func stop() {
        self.startTime = nil
        self.timer?.invalidate()
    }
    
    func pause() {
        self.timer?.invalidate()
    }
    
    func reset() {
        self.startTime = nil
        self.timer?.invalidate()
        guard self.delegate != nil else {
            return
        }
        self.delegate?.currentStopwatchTime(elapsedTime: self.elapsedTimeString)
    }
}
