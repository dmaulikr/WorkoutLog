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
    
    // MARK: - Table view data source

    //TODO: Fix this
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let day = day,
            let exercises = day.exercises else { return 0 }
        return 0
    }
    
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
