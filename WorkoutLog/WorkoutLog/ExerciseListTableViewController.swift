//
//  ExerciseListTableViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ExerciseListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Internal Properties
    var routine: Routine?
    var day: Day?
    var exercises: [Exercise]?
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let day = day,
//            let exercises = day.exercises else { return ""}
//        let exerciseArray = Array{exercises}
//        guard let exercise = exerciseArray[section] as? Exercise else { return ""}
//        return exercise.name
//    }
    

    //TODO: Fix this
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let day = day,
            let exercises = day.exercises else { return 0 }
        let exerciseArray = Array(exercises)
        guard let exercise = exerciseArray[section] as? Exercise else { return 0 }

        return exercise.sets?.count ?? 0
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return day?.exercises?.count ?? 0
    }
    
    //TODO: - Make a good cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
//        if day != nil {
//            let exercise = day?.exercises?[indexPath.row] as! Exercise
//            cell.updateViews(set: exercise)
//        }
        
        guard let day = day,
            let exercises = day.exercises else { return cell }
        
        let exerciseArray = Array(exercises) as! [Exercise]
        
        let exercise = exerciseArray[indexPath.section]
        
        let sets = exercise.sets
        
        guard let set = sets?[indexPath.row] as? Sets else { return cell }
        
        cell.updateViews(set: set, exercise: exercise)
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistorySegue" {
            guard let destinationVC = segue.destination as? ExerciseHistoryTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let exercise = day?.exercises?[indexPath.row] as! Exercise
            destinationVC.navigationItem.title = exercise.name
            destinationVC.exercise = exercise
        }
    }

}
