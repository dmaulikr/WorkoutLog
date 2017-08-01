//
//  ProgressHistoryViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ProgressHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var progresses: [Progress]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        progresses = ProgressController.shared.progresses
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProgressController.shared.progresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProgressHistoryTableViewCell else { return UITableViewCell() }
        
        if let progresses = progresses {
            let progress = progresses[indexPath.row]
            cell.updateViews(progress: progress)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let progress = ProgressController.shared.progresses[indexPath.row]
            ProgressController.shared.deleteProgress(progress: progress)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
