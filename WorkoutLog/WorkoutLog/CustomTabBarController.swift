//
//  CustomTabBarController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/26/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController, CustomTabBarViewDelegate {
    
    let tabBarHeight: CGFloat = 50.0
    var tabView: CustomTabBarView!
    
    override var selectedIndex: Int {
        didSet {
            tabView.setAppearance(forIndex: selectedIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isHidden = true
        
        let frame = CGRect(x: 0, y: view.frame.height - tabBarHeight, width: view.frame.width, height: tabBarHeight)
        tabView = CustomTabBarView(frame: frame)
        tabView.delegate = self
        tabView.setAppearance(forIndex: 0)
        
        view.addSubview(tabView)
        
    }

    func tabBarButtonTapped(at index: Int) {
        self.selectedIndex = index
    }

}
