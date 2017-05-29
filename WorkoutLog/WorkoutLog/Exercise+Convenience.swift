//
//  Exercise+Convenience.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/29/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

extension Exercise {
    convenience init(name: String,
                     sets: Int64 = 1,
                     reps: Int64 = 1,
                     weight: Double = 0.0,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}
