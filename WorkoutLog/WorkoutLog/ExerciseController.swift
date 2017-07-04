//
//  ExerciseController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

class ExerciseController {
    
    // MARK: - Shared Instance 
    static let shared = ExerciseController()
    
    // MARK: - Internal Properties
    var exercises: [Exercise] {
        let request: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    var currentDayExercise: Exercise?
    
    // MARK: - CRUD
    func createExercise(name: String, initialSets: Int64?, date: NSDate = NSDate()) -> Exercise {
        let initialSets = initialSets ?? 1
        let exercise = Exercise(name: name, initialSets: initialSets, date: date, context: CoreDataStack.context)
        saveToPersistentStorage()
        return exercise
    }
    
    func updatedExercise(exercise: Exercise, setNumber: Int64) -> Exercise {
        if let name = exercise.name {
            let date = NSDate()
            let updatedExercise = Exercise(name: name, initialSets: setNumber, date: date, context: CoreDataStack.context)
            return updatedExercise
        }
        saveToPersistentStorage()
        return exercise
    }
    
//    func updateExercise(exercise: Exercise, reps: Int64?, weight: Double?) -> Exercise {
//        if let reps = reps {
//            exercise.reps = reps
//        }
//        if let weight = weight {
//            exercise.weight = weight
//        }
//        saveToPersistentStorage()
//        return exercise
//    }
//    
    func deleteExercise(exercise: Exercise, from day: Day) {
        let moc = exercise.managedObjectContext
        moc?.delete(exercise)
        day.removeFromExercises(exercise)
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    func saveToPersistentStorage() {
        (try? CoreDataStack.context.save())
    }
}
