//
//  RoutineController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

class RoutineController {
    
    //MARK: - Shared Instance
    
    //MARK: - Internal Properties
    var routines: [Routine] {
        let request: NSFetchRequest<Routine> = Routine.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    //MARK: - CRUD
    func createRoutine(name: String) -> Routine {
        let routine = Routine(name: name, context: CoreDataStack.context)
        saveToPersistentStorage()
        return routine
    }
    
    func deleteRoutine(routine: Routine) {
        let moc = routine.managedObjectContext
        moc?.delete(routine)
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    func saveToPersistentStorage() {
        (try? CoreDataStack.context.save())
    }
}
