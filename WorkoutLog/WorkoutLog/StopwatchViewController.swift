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
    var timer = Timer()
    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
        timeLabel.text = "\(counter)"
        
        
        view.backgroundColor = UIColor.exerciseLightBlue
        timeLabel.textColor = UIColor.exerciseWhite
    }

    func singleTapped() {
        if isPlaying {
            timer.invalidate()
            isPlaying = false
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isPlaying = true
        }
    }
    
    func doubleTapped() {
        isPlaying = false
        timer.invalidate()
        counter = 00.00
        timeLabel.text = "\(counter)"
    }
    
    func updateTimer() {
        counter = counter + 0.1
        timeLabel.text = String(format: "%.1f", counter)
    }
    
}







