//
//  DayController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

class DayController {
    
    //MARK: - Shared Instance
    static let shared = DayController()
    
    //MARK: - Internal Properties
    var days: [Day] {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    //MARK: - CRUD
    
    func createDay(name: String) -> Day {
        let day = Day(name: name, context: CoreDataStack.context)
        saveToPersistantStorage()
        return day
    }
    
    func deleteDay(day: Day) {
        let moc = day.managedObjectContext
        moc?.delete(day)
        saveToPersistantStorage()
    }
    
    //MARK: - Persistence
    func saveToPersistantStorage() {
        (try? CoreDataStack.context.save())
    }
}
