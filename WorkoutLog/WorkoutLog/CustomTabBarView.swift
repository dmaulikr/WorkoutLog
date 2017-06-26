//
//  CustomTabBarView.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/26/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTabBarViewDelegate: class {
    func tabBarButtonTapped(at index: Int)
}

class CustomTabBarView: UIView {

    var imageView0 = UIImageView()
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    
    var label0 = UILabel()
    var label1 = UILabel()
    var label2 = UILabel()
    
    var button0 = UIButton()
    var button1 = UIButton()
    var button2 = UIButton()
    
    weak var delegate: CustomTabBarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button0.tag = 0
        button1.tag = 1
        button2.tag = 2
        
        button0.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
        button1.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAppearance(forIndex index: Int) {
        imageView0.tintColor = UIColor.exerciseWhite
        imageView1.tintColor = UIColor.exerciseWhite
        imageView2.tintColor = UIColor.exerciseWhite
        
        label0.textColor = UIColor.exerciseWhite
        label1.textColor = UIColor.exerciseWhite
        label2.textColor = UIColor.exerciseWhite
        
        switch index {
        case 0:
            imageView0.tintColor = UIColor.exerciseLightBlue
            label0.textColor = UIColor.exerciseLightBlue
        case 1:
            imageView1.tintColor = UIColor.exerciseLightBlue
            label1.textColor = UIColor.exerciseLightBlue
        case 2:
            imageView2.tintColor = UIColor.exerciseLightBlue
            label2.textColor = UIColor.exerciseLightBlue
        default:
            break
        }
    }
    
    func didTap(sender: UIButton) {
        delegate?.tabBarButtonTapped(at: sender.tag)
    }

}











