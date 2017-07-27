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
import NotificationCenter

class NewStopwatchViewController: UIViewController, StopwatchDelegate {
    
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func circleButtonTapped(_ sender: Any) {
        singleTapped()
    }
    @IBAction func thirtySecondButtonTapped(_ sender: Any) {
        self.cancelNotification()
        timeCount = 30.0
        self.timeRemaining = timeCount
        self.stopwatch.type = StopwatchType.CountDown
        self.stopwatch.countDownTime = timeCount
        self.stopwatch.start()
        self.isPlaying = true
        self.scheduleLocalNotification()
    }
    @IBAction func oneMinuteButtonTapped(_ sender: Any) {
        self.cancelNotification()
        timeCount = 60.0
        self.timeRemaining = timeCount
        self.stopwatch.type = StopwatchType.CountDown
        self.stopwatch.countDownTime = timeCount
        self.stopwatch.start()
        isPlaying = true
        self.scheduleLocalNotification()
    }
    @IBAction func twoMinuteButtonTapped(_ sender: Any) {
        self.cancelNotification()
        timeCount = 120.0
        self.timeRemaining = timeCount
        self.stopwatch.type = StopwatchType.CountDown
        self.stopwatch.countDownTime = timeCount
        self.stopwatch.start()
        isPlaying = true
        self.scheduleLocalNotification()
    }
    @IBAction func threeMinuteButtonTapped(_ sender: Any) {
        self.cancelNotification()
        timeCount = 180.0
        self.timeRemaining = timeCount
        self.stopwatch.type = StopwatchType.CountDown
        self.stopwatch.countDownTime = timeCount
        self.stopwatch.start()
        isPlaying = true
        self.scheduleLocalNotification()
    }
    
    //MARK: - Internal Properties
    
    var isPlaying: Bool = false
    var timeCount: TimeInterval = 0.0
    var timeRemaining: TimeInterval?
    
    var statusBar = UIStatusBarStyle.self
    
    lazy var stopwatch: Stopwatch = Stopwatch()
    
    fileprivate let userNotificationIdentifier = "timerNotification"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        statusBarView.backgroundColor = UIColor.exerciseDarkBlue
        self.stopwatch.delegate = self
    }
    
    //MARK: - Notification

    func scheduleLocalNotification() {
        // Notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.sound = UNNotificationSound.default()
        notificationContent.title = "Timer is finished!"
        notificationContent.body = "Get back to work!"
        
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
    
    //MARK: - Internal Methods
    
    func singleTapped() {
        if !isPlaying {
            self.stopwatch.type = StopwatchType.CountUp
            self.stopwatch.start()
            self.isPlaying = true
        } else if isPlaying {
            self.stopwatch.pause()
            self.isPlaying = false
        }
    }
    
    func doubleTapped() {
        self.isPlaying = false
        self.stopwatch.reset()
        self.cancelNotification()
    }
    
    //MARK: - Delegate Method
    
    func currentStopwatchTime(elapsedTime: String) {
        self.timeLabel.text = elapsedTime
    }
}
