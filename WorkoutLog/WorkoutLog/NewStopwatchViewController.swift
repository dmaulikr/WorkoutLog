//
//  NewStopwatchViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class NewStopwatchViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func circleButtonTapped(_ sender: Any) {
        singleTapped()
    }
    @IBAction func thirtySecondButtonTapped(_ sender: Any) {
    }
    @IBAction func oneMinuteButtonTapped(_ sender: Any) {
    }
    @IBAction func twoMinuteButtonTapped(_ sender: Any) {
    }
    @IBAction func threeMinuteButtonTapped(_ sender: Any) {
    }
    
    var startTime = TimeInterval()
    
    var timer: Timer = Timer()
    
    var isPlaying: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singleTap.numberOfTapsRequired = 1
        //view.addGestureRecognizer(singleTap)
    }

    func singleTapped() {
        if (isPlaying == false) {
            let aSelector: Selector = "updateTime"
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
            isPlaying = true
        } else {
            timer.invalidate()
            isPlaying = false
        }
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        timeLabel.text = "\(strMinutes):\(strSeconds).\(strFraction)"
    }
}
