//
//  EditDayTableViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class EditDayTableViewController: UITableViewController {
    
    @IBAction func addButtonTapped(_ sender: Any) {
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
                //self.sets.append(set) //TODO: Fix this
                i += 1
            }
            
//            self.weight.append(weight)
//            self.reps.append(reps)
//            self.exercise = exercise
//            //exercise.addToSets(set)
//            self.exercises.append(exercise) // Not sure about this either
            guard let day = self.day else { return }
            self.day?.addToExercises(exercise) // Not sure about this
            self.delegate?.updateDay(day: day)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addedAction)
        self.present(alertController, animated: true, completion: nil)
    }

    var day: Day?
    var delegate: EditedDayDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.clearsSelectionOnViewWillAppear = false

        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return day?.exercises?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)

        guard let day = day,
            let exercises = day.exercises else { return cell }
        guard let exerciseArray = Array(exercises) as? [Exercise] else { return cell }
        let exercise = exerciseArray[indexPath.row]
        
        cell.textLabel?.text = exercise.name

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let day = day,
                let exercise = day.exercises?[indexPath.row] as? Exercise else { return }
            ExerciseController.shared.deleteExercise(exercise: exercise, from: day)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

protocol EditedDayDelegate {
    func updateDay(day: Day)
}
