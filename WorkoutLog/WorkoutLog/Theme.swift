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
        UINavigationBar.appearance().barTintColor = UIColor.exerciseGreen
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.exerciseOrange]
    }
}
