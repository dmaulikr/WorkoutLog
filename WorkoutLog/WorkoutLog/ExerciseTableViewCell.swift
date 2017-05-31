//
//  ExerciseTableViewCell.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lastWeightLabel: UILabel!
    @IBOutlet weak var lastRepsLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    var exercise: Exercise?
    
    func updateViews(exercise: Exercise) {
        self.exercise = exercise
        lastWeightLabel.text = "\(exercise.weight)"
        lastRepsLabel.text = "\(exercise.reps)"
    }
    
    func updateExercise(exercise: Exercise) -> Exercise {
        guard let weightString = weightTextField.text,
            let repsString = repsTextField.text else { return exercise }
        guard let weight = Double(weightString),
            let reps = Int64(repsString) else { return exercise }
        let updatedExercise = ExerciseController.shared.updateExercise(exercise: exercise, reps: reps, weight: weight)
        return updatedExercise
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
