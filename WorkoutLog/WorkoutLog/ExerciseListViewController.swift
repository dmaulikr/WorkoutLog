//
//  ExerciseListViewController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/26/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

//MARK: - Protocols

protocol CheckmarkButtonTappedDelegate {
    func checkmarkButtonTapped(sender: Any)
}

class ExerciseListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Outlets and Actions
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Internal Properties
    
    var routine: Routine?
    //TODO: Fix data sent from editDayTableViewController
    var day: Day? {
        willSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    var exercises: [Exercise]?
    var selectedExercise: Exercise?
    var button: UIButton?
    var delegate: CheckmarkButtonTappedDelegate?
    
    // MARK Section Header Methods
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let day = day,
            let exercises = day.exercises else { return ""}
        let exerciseArray = Array(exercises)
        guard let exercise = exerciseArray[section] as? Exercise else { return ""}
        
        return exercise.name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = .white
        let headerColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 0.8)
        let titleColor = UIColor.exerciseWhite
        //view.tintColor = headerColor
        header.contentView.backgroundColor = headerColor
        header.clipsToBounds = true
        header.textLabel?.font = header.textLabel?.font.withSize(20)
        header.textLabel?.textColor = titleColor
        
        //Add button to header view
        let button = UIButton(frame: CGRect(x: tableView.frame.width - (header.frame.height + 10), y: 0, width: header.frame.height, height: header.frame.height))
        
        self.button = button
        button.tag = section
        
        button.setImage(#imageLiteral(resourceName: "checkmarkBlue"), for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(saveExercise(sender:)), for: .touchUpInside)
        
        header.addSubview(button)
    }
    
    func saveExercise(sender: Any?) {
        guard let button = sender as? UIButton else { return }
        button.setImage(#imageLiteral(resourceName: "checkmarkBlue"), for: UIControlState.normal)
        delegate?.checkmarkButtonTapped(sender: self)
        guard let exercises = day?.exercises,
        let exerciseArray = Array(exercises) as? [Exercise] else { return }
        let exercise = exerciseArray[button.tag]
        let sets = exercise.initialSets
        
        let updatedExercise = ExerciseController.shared.updatedExercise(exercise: exercise, setNumber: sets)
        self.day?.addToExercises(updatedExercise)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let day = day,
            let exercises = day.exercises else { return 0 }
        let exerciseArray = Array(exercises)
        guard let exercise = exerciseArray[section] as? Exercise else { return 0 }
        return exercise.sets?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return day?.exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
        
        guard let day = day,
            let exercises = day.exercises else { return cell }
        
        let exerciseArray = Array(exercises) as! [Exercise]
        
        let exercise = exerciseArray[indexPath.section]
        
        let sets = exercise.sets
        
        guard let set = sets?[indexPath.row] as? Sets else { return cell }
        
        cell.updateViews(set: set, exercise: exercise, VC: self)
        
        cell.delegate = self
        
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

//MARK: - ExerciseTableViewCellDelegate Methods

extension ExerciseListViewController: ExerciseTableViewCellDelegate {
    func startTextFieldEnter(sender: Any) {
        button?.setImage(#imageLiteral(resourceName: "checkmarkOrange"), for: .normal)
    }
}
