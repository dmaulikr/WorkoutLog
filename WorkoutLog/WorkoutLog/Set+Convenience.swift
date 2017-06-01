//
//  Set+Convenience.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 5/31/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

extension Sets {
    convenience init(weight: Double,
                     reps: Int64,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.weight = weight
        self.reps = reps
    }
}