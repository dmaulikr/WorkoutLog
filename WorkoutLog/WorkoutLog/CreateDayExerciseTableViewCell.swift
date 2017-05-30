//
//  CreateDayExerciseTableViewCell.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class CreateDayExerciseTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var setsNumberLabel: UILabel!
    @IBOutlet weak var repsNumberLabel: UILabel!
    @IBOutlet weak var weightNumberLabel: UILabel!
    
    //MARK: - Internal Properties
    
    var exercise: Exercise?
    
    func updateViews(exercise: Exercise) {
        self.exercise = exercise
        nameLabel.text = exercise.name
        setsNumberLabel.text = "\(exercise.sets)"
        repsNumberLabel.text = "\(exercise.reps)"
        weightNumberLabel.text = "\(exercise.weight)"
    }

}
