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
    
    @IBAction func weightEntered(_ sender: Any) {
        guard let set = set else { return }
        updateSetWeight(set: set)
    }
    @IBAction func repsEntered(_ sender: Any) {
        guard let set = set else { return }
        updateSetReps(set: set)
    }
    
    
    var exercise: Exercise?
    var set: Sets?
    
    func updateViews(set: Sets, exercise: Exercise) {
        self.set = set
        lastWeightLabel.text = "\(set.weight)"
        lastRepsLabel.text = "\(set.reps)"
    }
    
    func updateViewsWithoutTitle(set:Sets) {
        self.set = set
        lastWeightLabel.text = "\(set.weight)"
        lastRepsLabel.text = "\(set.reps)"
    }
    
    func updateSetWeight(set: Sets) -> Sets {
        guard let weightString = weightTextField.text else { return set }
        guard let weight = Double(weightString) else { return set }
        let updatedSet = SetController.shared.updateSet(set: set, weight: weight, reps: nil)
        return updatedSet
    }
    
    func updateSetReps(set: Sets) -> Sets {
        guard let repsString = repsTextField.text else { return set }
        guard let reps = Int64(repsString) else { return set }
        let updatedSet = SetController.shared.updateSet(set: set, weight: nil, reps: reps)
        return updatedSet
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
