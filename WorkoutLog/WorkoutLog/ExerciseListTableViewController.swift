//
//  ExerciseListTableViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/30/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class ExerciseListTableViewController: UITableViewController, EditedDayDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //Timer button
        self.timerButton = UIButton(type: .custom)
        self.timerButton.setTitleColor(.orange, for: .normal)
        self.timerButton.addTarget(self, action: #selector(ButtonClick(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(timerButton)
    }
    
    override func viewWillLayoutSubviews() {
        timerButton.layer.cornerRadius = timerButton.layer.frame.size.width/2
        timerButton.clipsToBounds = true
        timerButton.backgroundColor = .gray
        timerButton.setImage(UIImage(named: "alarmIconSelected"), for: .normal)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3), timerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -55), timerButton.widthAnchor.constraint(equalToConstant: 50), timerButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    @IBAction func ButtonClick(_ sender: UIButton) {
        
    }

    // MARK: - Internal Properties
    var routine: Routine?
    //TODO: Fix data sent from editDayTableViewController
    var day: Day? {
        willSet {
            tableView.reloadData()
        }
    }
    var exercises: [Exercise]?
    
    var timerButton = UIButton()
    
    // MARK Section Header Methods
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let day = day,
            let exercises = day.exercises else { return ""}
        let exerciseArray = Array(exercises)
        guard let exercise = exerciseArray[section] as? Exercise else { return ""}
        
        return exercise.name
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = .white
        //let headerColor = UIColor(red: 0/255, green: 64/255, blue: 94/255, alpha: 1.0)
        let headerColor = UIColor.exerciseBlue
        //view.tintColor = headerColor
        header.contentView.backgroundColor = headerColor
        header.clipsToBounds = true
        header.textLabel?.font = header.textLabel?.font.withSize(20)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        let headerColor = UIColor(red: 0/255, green: 64/255, blue: 94/255, alpha: 1.0)
        footer.contentView.backgroundColor = headerColor
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label: UILabel = UILabel()
//        label.textAlignment = .center
//        //label.adjustsFontSizeToFitWidth = true
//        return label
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
    
    //MARK: - Delegate Method
    
    func updateDay(day: Day) {
        self.day = day
        tableView.reloadData()
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
        
        if segue.identifier == "toEditSegue" {
            guard let destinationVC = segue.destination as? EditDayTableViewController else { return }
            guard let day = day else { return }
            destinationVC.day = day
        }
    }

}
