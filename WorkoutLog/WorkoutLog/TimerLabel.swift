//
//  TimerLabel.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 7/27/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class TimerLabel: UILabel {

    var timerIntervalToDisplay: TimeInterval! {
        didSet {
            let minutes = Int(timerIntervalToDisplay) / 60 % 60
            let seconds = Int(timerIntervalToDisplay) % 60
            let miliseconds = Int((timerIntervalToDisplay * 10).truncatingRemainder(dividingBy: 10))
            self.text = String(format: "%2i:%02i.%i", minutes, seconds, miliseconds)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUp()
    }
    
    private func setUp() {
        self.textColor = UIColor.exerciseDarkBlue
    }

}
