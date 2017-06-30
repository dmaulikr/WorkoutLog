

//
//  ExerciseTableViewCell.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

//MARK: - Protocols

protocol ExerciseTableViewCellDelegate {
    func startTextFieldEnter(sender: Any)
}

class ExerciseTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var lastWeightLabel: UILabel!
    @IBOutlet weak var lastRepsLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var savedLabel: UILabel!
    
    @IBAction func weightEntered(_ sender: Any) {
        delegate?.startTextFieldEnter(sender: self)
        guard let set = set,
            let exercise = exercise else { return }
        newSet = updateSetWeight(set: set)
        if newExercise == nil {
            newExercise = ExerciseController.shared.updatedExercise(exercise: exercise)
            newExercise?.addToSets(set)
        }
    }
    @IBAction func repsEntered(_ sender: Any) {
        delegate?.startTextFieldEnter(sender: self)
        guard let set = set else { return }
        newSet = updateSetReps(set: set)
    }
    @IBAction func noteEntered(_ sender: Any) {
        delegate?.startTextFieldEnter(sender: self)
        guard let set = set else { return }
        newSet = updateSetNote(set: set)
    }
    
    //MARK: - Internal Properties
    
    var exercise: Exercise?
    var set: Sets?
    var newExercise: Exercise?
    var newSet: Sets?
    var delegate: ExerciseTableViewCellDelegate?
    var timer: Timer!
    
    var arrayOfWeight: [String] = [String]()
    var arrayOfSets: [String] = [String]()
    var weightRowBeingEdited: Int? = nil
    var repsRowBeingEdited: Int? = nil
    
    //MARK: - Internal Methods
    
    override func prepareForReuse() {
        weightTextField.text = ""
        repsTextField.text = ""
        noteTextField.text = ""
    }
    
    func updateViews(set: Sets, exercise: Exercise, VC: Any) {
        self.set = set
        lastWeightLabel.text = "\(set.weight)"
        lastRepsLabel.text = "\(set.reps)"
        noteTextField.placeholder = set.note
        savedLabel.isHidden = true
        
        guard let vc = VC as? ExerciseListViewController else { return }
        vc.delegate = self
        
//        if arrayOfWeight != nil {
//            weightTextField.text = arrayOfWeight[num]
//        } else {
//            weightTextField.text = ""
//        }
//        if arrayOfSets != nil {
//            repsTextField.text = arrayOfSets[num]
//        } else {
//            repsTextField.text = ""
//        }
//        
//        weightTextField.tag = num
//        repsTextField.tag = num
//        
//        weightTextField.delegate = self
//        repsTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        let weightRow = weightTextField.tag
//        let repsRow = repsTextField.tag
//        if weightRow >= arrayOfWeight.count {
//            for _ in ((arrayOfWeight.count)..<weightRow+1) {
//                arrayOfWeight.append("")
//            }
//        }
//        arrayOfWeight[weightRow] = weightTextField.text!
//        weightRowBeingEdited = nil
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        weightRowBeingEdited = weightTextField.tag
//        
//    }
    
    //MARK: - Update Methods
    
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
    
}


//MARK: - CheckmarkButtonTappedDelegate Methods

extension ExerciseTableViewCell: CheckmarkButtonTappedDelegate {
    
    func checkmarkButtonTapped(sender: Any) {
        savedLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(endTimer), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        savedLabel.isHidden = true
        timer.invalidate()
    }
}
