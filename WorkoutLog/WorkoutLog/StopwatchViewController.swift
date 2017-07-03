//
//  StopwatchViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/26/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!

    var counter = 00.00
    var minuteCounter = 00
    var timer = Timer()
    var isPlaying = false
    
    let watch = Stopwatch()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
        timeLabel.text = "00:00.00"


        view.backgroundColor = UIColor.exerciseLightBlue
        timeLabel.textColor = UIColor.exerciseWhite
    }
    
    func updateElapsedTimeLabel() {
            let minutes = Int(watch.elapsedTime/60)
            let seconds = Int(watch.elapsedTime .truncatingRemainder(dividingBy: 60))
            let tensOfSeconds = Int(watch.elapsedTime * 10 .truncatingRemainder(dividingBy: 10))
            timeLabel.text = String(format: "%02d:%02d.%d", minutes, seconds, tensOfSeconds)
    }

    func singleTapped() {
        if isPlaying {
            timer.invalidate()
            isPlaying = false
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
            //updateElapsedTimeLabel()
            isPlaying = true
        }
    }
    
    func doubleTapped() {
        isPlaying = false
        timer.invalidate()
//        counter = 00.00
        timeLabel.text = "00:00.00"
    }
    
//    func updateTimer() {
//        if counter >= 60 {
//            minuteCounter += 1
//
//            counter = 00.00
//        }
//        counter = counter + 0.1
//        timeLabel.text = String(format: "%0.1f", counter)
//        
//    }
    
}







