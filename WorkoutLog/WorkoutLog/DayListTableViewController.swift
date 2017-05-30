//
//  DayListTableViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class DayListTableViewController: UITableViewController {
    
    //TODO: Add segue after Add button tapped
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Day", message: "Add a name for your new day.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        var nameTextField: UITextField?
        
        alertController.addTextField { (textField) in
            nameTextField = textField
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
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
    
    
    var routine: Routine?
    var day: Day?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let days = routine?.days else { return 0 }
        return days.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)

        let day = routine?.days?[indexPath.row] as? Day
        cell.textLabel?.text = day?.name

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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateDaySegue" {
            guard let destinationVC = segue.destination as? CreateDayTableViewController else { return }
            guard let routine = routine else { return }
            guard let day = day else { return }
            destinationVC.routine = routine
            destinationVC.day = day
            destinationVC.navigationItem.title = day.name
        }
    }

}
