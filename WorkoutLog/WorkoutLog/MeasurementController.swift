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
    
    var Measurements: [Measurement]?
    
    //MARK: - CRUD
    func createMeasurement(name: String, measurement: Double) -> Measurement {
        let newMeasurement = Measurement(name: name, measurement: measurement)
        return newMeasurement
        
    }
    
    func deleteMeasurement(measurement: Measurement) {
        
    }
    
}
