//
//  CreateDayViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 7/20/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CreateDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Exercise", message: "Add a new exercise to your workout", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        var nameTextField: UITextField?
        var setsTextField: UITextField?
        var repsTextField: UITextField?
        var weightTextField: UITextField?
        
        alertController.addTextField { (textField) in
            nameTextField = textField
            textField.placeholder = "Required: Exercise name..."
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .words
            textField.spellCheckingType = .yes
        }
        alertController.addTextField { (textField) in
            setsTextField = textField
            textField.placeholder = "Number of sets... Default 1"
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { (textField) in
            repsTextField = textField
            textField.placeholder = "Number of reps... Default 1"
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { (textField) in
            weightTextField = textField
            textField.placeholder = "Most recent weight used..."
            textField.keyboardType = .decimalPad
        }
        //TODO: fix this shit
        let addedAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = nameTextField?.text else { return }
            var sets: Int64
            var reps: Int64
            var weight: Float
            if (setsTextField?.text?.isEmpty)! {
                sets = 1
            } else {
                sets = Int64((setsTextField?.text)!)!
            }
            if (repsTextField?.text?.isEmpty)! {
                reps = 1
            } else {
                reps = Int64((repsTextField?.text)!)!
            }
            if (weightTextField?.text?.isEmpty)! {
                weight = 0.0
            } else {
                weight = Float((weightTextField?.text)!)!
            }
            let exercise = ExerciseController.shared.createExercise(name: name, initialSets: sets)
            var i = 0
            //TODO amount of sets added might be off
            while i < Int(exercise.initialSets) {
                let set = SetController.shared.createSet(weight: weight, reps: reps, note: nil)
                exercise.addToSets(set)
                self.sets.append(set) //TODO: Fix this
                i += 1
            }
            
            self.weight.append(weight)
            self.reps.append(reps)
            self.exercise = exercise
            //exercise.addToSets(set)
            self.exercises.append(exercise) // Not sure about this either
            self.day.addToExercises(exercise) // Not sure about this
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addedAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Internal Properties
    
    var sets: [Sets] = []
    var exercises: [Exercise] = []
    var routine: Routine?
    var day: Day!
    var exercise: Exercise? //TODO: Fix this
    var weight: [Float] = []
    var reps: [Int64] = []

    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add exercise to day"
        let backButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    //TODO: Fix this
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? CreateDayExerciseTableViewCell else { return UITableViewCell() }
        
        let exercise = exercises[indexPath.row]
        let weight = self.weight[indexPath.row]
        let reps = self.reps[indexPath.row]
        //let set = sets[indexPath.row]
        
        cell.updateViews(exercise: exercise, weight: weight, reps: reps)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let exercise = exercises[indexPath.row]
            ExerciseController.shared.deleteExercise(exercise: exercise, from: day)
            guard let index = exercises.index(of: exercise) else { return }
            exercises.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
