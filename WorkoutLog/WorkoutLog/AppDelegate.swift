//
//  AppDelegate.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Theme.configureAppearance()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if !granted {
                print("Notification access has been denied")
            }
        }
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
}

