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
                     initialSets: Int64 = 1,
                     date: NSDate,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.initialSets = initialSets
        self.date = date
    }
}
