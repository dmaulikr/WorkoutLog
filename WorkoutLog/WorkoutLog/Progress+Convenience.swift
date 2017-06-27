//
//  Progress+Convenience.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/27/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData

extension Progress {
    convenience init(photo: NSData,
                     date: NSDate,
                     weight: Double,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.photo = photo
        self.date = date
        self.weight = weight
    }
}
