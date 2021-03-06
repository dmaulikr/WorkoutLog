//
//  DayListViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 7/20/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class DayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addDayButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Day", message: "Add a name for your new day.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        var nameTextField: UITextField?
        
        alertController.addTextField { (textField) in
            nameTextField = textField
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .words
            textField.spellCheckingType = .yes
            textField.placeholder = "Name of day..."
        }
        let addedAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = nameTextField?.text else { return }
            let day = DayController.shared.createDay(name: name)
            self.routine?.addToDays(day)
            self.day = day
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.performSegue(withIdentifier: "toCreateDaySegue", sender: self)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addedAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    //MARK: - Internal Properties
    
    var routine: Routine?
    var day: Day?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if routine?.days?.count == 0 {
            navigationItem.title = "Add a day to your routine"
        } else {
            guard let routine = routine,
                let name = routine.name else { return }
            navigationItem.title = "\(name)"
        }
        
        // Turn
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let days = routine?.days else { return 0 }
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = routine?.days?[indexPath.row] as? Day
        cell.textLabel?.text = day?.name
        if day?.exercises?.count == 1 {
            cell.detailTextLabel?.text = "1 exercise"
        } else {
            cell.detailTextLabel?.text = "\(day?.exercises?.count ?? 0) exercises"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let routine = routine else { return }
            guard let day = routine.days?[indexPath.row] as? Day else { return }
            DayController.shared.deleteDay(day: day, from: routine)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateDaySegue" {
            guard let destinationVC = segue.destination as? CreateDayViewController else { return }
            guard let routine = routine else { return }
            guard let day = day else { return }
            destinationVC.routine = routine
            destinationVC.day = day
            destinationVC.navigationItem.title = day.name
        }
        
        if segue.identifier == "toExerciseListSegue" {
            guard let destinationVC = segue.destination as? ExerciseListViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let routine = routine,
                let day = routine.days?[indexPath.row] as? Day else { return }
            destinationVC.navigationItem.title = day.name
            destinationVC.day = day
        }
    }
    
}
