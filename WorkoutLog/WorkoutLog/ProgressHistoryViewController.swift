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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProgressController.shared.progresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProgressHistoryTableViewCell else { return UITableViewCell() }
        
        let progress = ProgressController.shared.progresses[indexPath.row]
        
        cell.updateViews(progress: progress)
        
        return cell
    }

}
