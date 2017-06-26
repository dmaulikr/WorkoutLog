//
//  Theme.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/22/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

enum Theme {
    static func configureAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.exerciseDarkBlue
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.exerciseWhite]
        UINavigationBar.appearance().barStyle = .blackOpaque
        
        UITabBar.appearance().barTintColor = UIColor.exerciseDarkBlue
        UITabBar.appearance().tintColor = UIColor.white
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.exerciseOrange], for: .highlighted)
    }
    
}
