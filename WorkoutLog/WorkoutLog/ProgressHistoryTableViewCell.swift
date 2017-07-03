//
//  ProgressHistoryTableViewCell.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ProgressHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    func updateViews(progress: Progress) {
        progressImage.image = progress.image
        guard let date = progress.date else { return }
        
        dateLabel.text = "\(date)"
        weightLabel.text = "\(progress.weight)"
    }

}
