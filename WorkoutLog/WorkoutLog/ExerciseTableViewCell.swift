//
//  ExerciseTableViewCell.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var lastWeightLabel: UILabel!
    @IBOutlet weak var lastRepsLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBAction func weightEntered(_ sender: Any) {
        guard let set = set else { return }
        updateSetWeight(set: set)
    }
    @IBAction func repsEntered(_ sender: Any) {
        guard let set = set else { return }
        updateSetReps(set: set)
    }
    @IBAction func noteEntered(_ sender: Any) {
        guard let set = set else { return }
        updateSetNote(set: set)
    }
    
    var exercise: Exercise?
    var set: Sets?
    
    func updateViews(set: Sets, exercise: Exercise) {
        self.set = set
        lastWeightLabel.text = "\(set.weight)"
        lastRepsLabel.text = "\(set.reps)"
        noteTextField.text = set.note
    }
    
    func updateSetWeight(set: Sets) -> Sets {
        guard let weightString = weightTextField.text else { return set }
        guard let weight = Float(weightString) else { return set }
        let updatedSet = SetController.shared.updateSet(set: set, weight: weight, reps: nil, note: nil)
        return updatedSet
    }
    
    func updateSetReps(set: Sets) -> Sets {
        guard let repsString = repsTextField.text else { return set }
        guard let reps = Int64(repsString) else { return set }
        let updatedSet = SetController.shared.updateSet(set: set, weight: nil, reps: reps, note: nil)
        return updatedSet
    }
    
    func updateSetNote(set: Sets) -> Sets {
        guard let note = noteTextField.text else { return set }
        let updatedSet = SetController.shared.updateSet(set: set, weight: nil, reps: nil, note: note)
        return updatedSet
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
