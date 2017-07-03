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
        let dateString = formatDate(date: date)
        
        dateLabel.text = dateString
        weightLabel.text = "Weight: \(progress.weight)"
        
        dateLabel.textColor = UIColor.exerciseDarkBlue
        weightLabel.textColor = UIColor.exerciseDarkBlue
    }
    
    func formatDate(date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        let dateString = formatter.string(from: date as Date)
        return dateString
    }

}
