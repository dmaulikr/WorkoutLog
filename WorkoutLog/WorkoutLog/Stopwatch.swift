//
//  Stopwatch.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/26/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation

class Stopwatch {
    
    private var startTime: NSDate?
    
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }
    
    func stop() {
        startTime = nil
    }
    
}
