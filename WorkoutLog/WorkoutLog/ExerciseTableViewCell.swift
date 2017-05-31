//
//  ExerciseTableViewCell.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var lastWeightLabel: UILabel!
    @IBOutlet weak var lastRepsLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func weightEntered(_ sender: Any) {
        guard let exercise = exercise else { return }
        updateExerciseWeight(exercise: exercise)
    }
    @IBAction func repsEntered(_ sender: Any) {
        guard let exercise = exercise else { return }
        updateExerciseReps(exercise: exercise)
    }
    
    
    var exercise: Exercise?
    
    func updateViews(exercise: Exercise) {
        self.exercise = exercise
        lastWeightLabel.text = "\(exercise.weight)"
        lastRepsLabel.text = "\(exercise.reps)"
        nameLabel.text = exercise.name
    }
    
    func updateExerciseWeight(exercise: Exercise) -> Exercise {
        guard let weightString = weightTextField.text else { return exercise }
        guard let weight = Double(weightString) else { return exercise }
        let updatedExercise = ExerciseController.shared.updateExercise(exercise: exercise, reps: nil, weight: weight)
        return updatedExercise
    }
    
    func updateExerciseReps(exercise: Exercise) -> Exercise {
        guard let repsString = repsTextField.text else { return exercise }
        guard let reps = Int64(repsString) else { return exercise }
        let updatedExercise = ExerciseController.shared.updateExercise(exercise: exercise, reps: reps, weight: nil)
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
