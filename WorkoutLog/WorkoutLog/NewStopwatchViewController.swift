//
//  NewStopwatchViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class NewStopwatchViewController: UIViewController {
    
    
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func circleButtonTapped(_ sender: Any) {
        singleTapped()
    }
    @IBAction func thirtySecondButtonTapped(_ sender: Any) {
        timeCount = 30.0
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    @IBAction func oneMinuteButtonTapped(_ sender: Any) {
        timeCount = 60.0
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    @IBAction func twoMinuteButtonTapped(_ sender: Any) {
        timeCount = 120.0
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    @IBAction func threeMinuteButtonTapped(_ sender: Any) {
        timeCount = 180.0
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    
    var startTime = TimeInterval()
    
    var timer: Timer = Timer()
    
    var isPlaying: Bool = false
    
    let timeInterval: TimeInterval = 0.01
    var timeCount: TimeInterval = 0.0
    
    var statusBar = UIStatusBarStyle.self

    override func viewDidLoad() {
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singleTap.numberOfTapsRequired = 1
        //view.addGestureRecognizer(singleTap)
        statusBarView.backgroundColor = UIColor.exerciseDarkBlue
        
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
    
    func timerDidEnd(timer:Timer) {
        timeCount = timeCount - timeInterval
        if timeCount <= 0 {
            timeLabel.text = "00:00.00"
            timer.invalidate()
            isPlaying = false
        } else {
            timeLabel.text = timeString(time: timeCount)
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format: "%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10))
    }
}
