//
//  ProgressController.swift
//  WorkoutLog
//
//  Created by Colton Lemmon on 6/27/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProgressController {
    
    //MARK: - Shared Instance
    
    static let shared = ProgressController()
    
    //MARK: - Internal Properties
    
    var progresses: [Progress] {
        let request: NSFetchRequest<Progress> = Progress.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    //MARK: - CRUD
    
    func createProgressWithPhotoAndWeight(photo: UIImage, weight: Double) {
        let date = NSDate()
        //let photoData = UIImagePNGRepresentation(photo)! as NSData
        guard let photoData = UIImageJPEGRepresentation(photo, 1.0) as NSData? else { return }
        _ = Progress(photo: photoData, date: date, weight: weight, context: CoreDataStack.context)
        saveToPersistentStorage()
    }
    
//    func createProgressWithPhotoOnly(photo: UIImage) -> Progress {
//        let date = NSDate()
//        let photoData = UIImagePNGRepresentation(photo)! as NSData
//        let progress = Progress(photo: photoData, date: date, weight: nil, context: CoreDataStack.context)
//        saveToPersistentStorage()
//        return progress
//    }
//    
//    func createProgressWithWeightOnly(weight: Double) -> Progress {
//        let date = NSDate()
//        let progress = Progress(photo: nil, date: date, weight: weight, context: CoreDataStack.context)
//        saveToPersistentStorage()
//        return progress
//    }
    
    func deleteProgress(progress: Progress) {
        let moc = progress.managedObjectContext
        moc?.delete(progress)
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    func saveToPersistentStorage() {
        (try? CoreDataStack.context.save())
    }
}
