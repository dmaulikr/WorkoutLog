//
//  Measurement+Convenience.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/27/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

extension Measurement {
    convenience init(name: String,
                     measurement: Double,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.measurement = measurement
    }
}
