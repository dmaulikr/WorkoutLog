//
//  ExerciseHistoryTableViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ExerciseHistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseHistoryCell", for: indexPath)

        // Configure the cell...

        return cell
    }
}
