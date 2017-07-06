//
//  NewStopwatchViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class NewStopwatchViewController: UIViewController {
    
    
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func circleButtonTapped(_ sender: Any) {
        singleTapped()
    }
    @IBAction func thirtySecondButtonTapped(_ sender: Any) {
        timeCount = 30.0
        timeRemaining = timeCount
        if !self.isPlaying {
            self.timeLabel.text = self.timeString(time: self.timeCount)
            self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(self.timerDidEnd(timer:)), userInfo: nil, repeats: true)
            self.isPlaying = true
            self.scheduleLocalNotification()
        }
    }
    @IBAction func oneMinuteButtonTapped(_ sender: Any) {
        timeCount = 60.0
        timeRemaining = timeCount
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
            self.scheduleLocalNotification()
        }
    }
    @IBAction func twoMinuteButtonTapped(_ sender: Any) {
        timeCount = 120.0
        timeRemaining = timeCount
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
            self.scheduleLocalNotification()
        }
    }
    @IBAction func threeMinuteButtonTapped(_ sender: Any) {
        timeCount = 180.0
        timeRemaining = timeCount
        if !isPlaying {
            timeLabel.text = timeString(time: timeCount)
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerDidEnd(timer:)), userInfo: nil, repeats: true)
            isPlaying = true
            self.scheduleLocalNotification()
        }
    }
    
    var startTime = TimeInterval()
    
    var timer: Timer = Timer()
    
    var isPlaying: Bool = false
    
    let timeInterval: TimeInterval = 0.01
    var timeCount: TimeInterval = 0.0
    var timeRemaining: TimeInterval?
    
    var statusBar = UIStatusBarStyle.self
    
    // Sound Effect
    var audioPlayer = AVAudioPlayer()
    fileprivate let userNotificationIdentifier = "timerNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapped))
        singleTap.numberOfTapsRequired = 1
        //view.addGestureRecognizer(singleTap)
        statusBarView.backgroundColor = UIColor.exerciseDarkBlue
        
        //Audio
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "coins", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Notification
    func scheduleLocalNotification() {
        // Notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.sound = UNNotificationSound.default()
        
        // Time remaining to date componenets
        guard let timeRemaining = self.timeRemaining else { return }
        let fireDate = Date(timeInterval: timeRemaining, since: Date())
        let dateComponents = Calendar.current.dateComponents([.minute, .second], from: fireDate)
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Request
        let request = UNNotificationRequest(identifier: userNotificationIdentifier, content: notificationContent, trigger: dateTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request. \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [userNotificationIdentifier])
    }

    func singleTapped() {
        if (isPlaying == false) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
            isPlaying = true
        } else {
            timer.invalidate()
            isPlaying = false
            cancelNotification()
        }
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
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
            timeRemaining = nil
            //audioPlayer.play()
        } else {
            timeLabel.text = timeString(time: timeCount)
            guard let timeRemaining = timeRemaining else { return }
            self.timeRemaining = timeRemaining - 1
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format: "%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10))
    }
}
