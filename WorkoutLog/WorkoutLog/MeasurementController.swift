//
//  MeasurementController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/27/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

class MeasurementController {
    
    //MARK: - Shared instance
    static let shared = MeasurementController()
    
    var Measurements: [Measurement] {
        let request: NSFetchRequest<Measurement> = Measurement.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    //MARK: - CRUD
    func createMeasurement(name: String, measurement: Double) -> Measurement {
        let newMeasurement = Measurement(name: name, measurement: measurement)
        saveToPersistentStorage()
        return newMeasurement
    }
    
    func deleteMeasurement(measurement: Measurement) {
        let moc = measurement.managedObjectContext
        moc?.delete(measurement)
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    func saveToPersistentStorage() {
        (try? CoreDataStack.context.save())
    }
    
}
