//
//  SetController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/31/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

class SetController {
    
    //MARK: - Shared Instance
    static let shared = SetController()
    
    //MARK: - Internal Properties
    var sets: [Sets] {
        let request: NSFetchRequest<Sets> = Sets.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    //MARK: - Crud
    func createSet(weight: Float?, reps: Int64?, note: String?) -> Sets {
        let weight = weight ?? 0.0
        let reps = reps ?? 1
        let note = note ?? ""
        let set = Sets(weight: weight, reps: reps, note: note, context: CoreDataStack.context)
        saveToPersistentStorage()
        return set
    }
    
    func updateSet(set: Sets, weight: Float?, reps: Int64?, note: String?) -> Sets {
        if let weight = weight {
            set.weight = weight
        }
        if let reps = reps {
            set.reps = reps
        }
        if let note = note {
            set.note = note
        }
        saveToPersistentStorage()
        return set
    }
    
    func deleteSet(set: Sets, from exercise: Exercise) {
        let moc = set.managedObjectContext
        moc?.delete(set)
        //exercise.removeFromSets(set)
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    func saveToPersistentStorage() {
        (try? CoreDataStack.context.save())
    }
    
}
