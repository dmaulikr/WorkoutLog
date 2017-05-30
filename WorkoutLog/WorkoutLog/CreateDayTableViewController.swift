//
//  CreateDayTableViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class CreateDayTableViewController: UITableViewController {
    
    //MARK: - Outlets and Actions

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
            textField.autocapitalizationType = .sentences
            textField.spellCheckingType = .yes
        }
        alertController.addTextField { (textField) in
            setsTextField = textField
            textField.placeholder = "Optional: Number of sets..."
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { (textField) in
            repsTextField = textField
            textField.placeholder = "Optional: Number of reps..."
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { (textField) in
            weightTextField = textField
            textField.placeholder = "Optional: Most recent weight used..."
            textField.keyboardType = .numberPad
        }
        //TODO: fix this shit
        let addedAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = nameTextField?.text else { return }
            var sets: Int64
            var reps: Int64
            var weight: Double
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
                weight = Double((weightTextField?.text)!)!
            }
            let exercise = ExerciseController.shared.createExercise(name: name, sets: sets, reps: reps, weight: weight)
            self.exercises?.append(exercise) // Not sure about this either
            self.day?.addToExercises(exercise) // Not sure about this
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addedAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Internal Properties
    
    var exercises: [Exercise]?
    var routine: Routine?
    var day: Day?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let day = day else { return 0 }
        return day.exercises!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? CreateDayExerciseTableViewCell else { return UITableViewCell() }
        
        guard let day = day else { return cell }
        guard let exercise = day.exercises?.array[indexPath.row] as? Exercise else { return cell  }
        cell.updateViews(exercise: exercise)
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
