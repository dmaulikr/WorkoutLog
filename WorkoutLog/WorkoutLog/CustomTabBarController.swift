//
//  CustomTabBarController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/26/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController, CustomTabBarViewDelegate, XMSegmentedControlDelegate {
    
    let tabBarHeight: CGFloat = 50.0
    var tabView: CustomTabBarView!
    var xmSegmentedControl: XMSegmentedControl!
    
    override var selectedIndex: Int {
        didSet {
        }
    }
    
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        selectedIndex = selectedSegment
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isHidden = true
        
        let backgroundColor = UIColor.exerciseDarkBlue
        let highlightColor = UIColor.exerciseOrange
        
        let titles = ["Progress", "Workout Log", "Stopwatch"]
        let icons = [UIImage(named: "camera-7")!, UIImage(named: "dumbbell-7")!, UIImage(named: "clock-stopwatch-7")!]
        let frame1 = CGRect(x: 0, y: self.view.frame.height - tabBarHeight, width: view.frame.width, height: tabBarHeight)
        
        let segmentedControl = XMSegmentedControl(frame: frame1, segmentIcon: icons, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.background)
        
        segmentedControl.backgroundColor = backgroundColor
        segmentedControl.highlightColor = highlightColor
        segmentedControl.tint = UIColor.exerciseWhite
        segmentedControl.highlightTint = UIColor.exerciseDarkBlue
        
        segmentedControl.delegate = self
        
        view.addSubview(segmentedControl)
        selectedIndex = 1
        segmentedControl.selectedSegment = 1
    }

    func tabBarButtonTapped(at index: Int) {
        self.selectedIndex = index
    }

}
