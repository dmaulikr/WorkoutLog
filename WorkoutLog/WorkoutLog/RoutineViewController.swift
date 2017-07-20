//
//  RoutineViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 7/19/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if RoutineController.shared.routines.count == 0 {
            navigationItem.title = "Add a routine to get started ->"
        } else {
            navigationItem.title = "Routines"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoutineController.shared.routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath)
        let routine = RoutineController.shared.routines[indexPath.row]
        cell.textLabel?.text = routine.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let routine = RoutineController.shared.routines[indexPath.row]
            RoutineController.shared.deleteRoutine(routine: routine)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDayListSegue" {
            guard let destinationVC = segue.destination as? DayListTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let routine = RoutineController.shared.routines[indexPath.row]
            if routine.days == nil {
                destinationVC.routine = routine
                destinationVC.navigationItem.title = "Please add a day to your routine ->"
            } else {
                destinationVC.routine = routine
                destinationVC.navigationItem.title = routine.name
                
            }
        }
    }

}
