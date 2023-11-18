import UIKit
import Foundation
import CoreData

protocol TrackerStoreProtocol {
    var context: NSManagedObjectContext { get }
    func addTracker(_ tracker: Tracker)
    //    func deleteTracker(_ tracker: TrackerCoreData)
}

final class TrackerStore: NSObject & TrackerStoreProtocol {
    // MARK: - Properties:
    var context: NSManagedObjectContext
    
    // MARK: - Methods:
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTracker(_ tracker: Tracker, with category: String) {
        let newTracker = TrackerCoreData(context: context)
        newTracker.id = tracker.id
        newTracker.name = tracker.name
        newTracker.color = tracker.color
        newTracker.emoji = tracker.emoji
        newTracker.setValue(tracker.schedule, forKey: "schedule")
        
    }
    
    /* MARK: - TODO: In next sprints
    func deleteTracker(_ tracker: TrackerCoreData) {
        context.delete(tracker)
    }
     */
}
