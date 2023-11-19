import UIKit
import Foundation
import CoreData

final class TrackerStore: NSObject  {
    // MARK: - Properties:
    var context: NSManagedObjectContext
    
    // MARK: - Methods:
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createCoreDataTracker(from tracker: Tracker, with category: String) {
        let newTracker = TrackerCoreData(context: context)
        newTracker.id = tracker.id
        newTracker.name = tracker.name
        newTracker.color = tracker.color
        newTracker.emoji = tracker.emoji
        newTracker.setValue(tracker.schedule, forKey: "schedule")
        newTracker.record = []
    }
    
    func createTrackerFromCoreData(_ object: TrackerCoreData) throws -> Tracker {
        guard
            let id = object.id,
            let name = object.name,
            let color = object.color,
            let emoji = object.emoji,
            let schedule = object.schedule else {
            print("Не удалось получить данные из БД")
            throw CoreDataErrors.creatingTrackerFromObjectError
        }
        return Tracker(
            id: id,
            name: name,
            schedule: schedule as! [Weekday],
            color: color,
            emoji: emoji)
    }
    
    /* MARK: - TODO: In next sprints
    func deleteTracker(_ tracker: TrackerCoreData) {
        context.delete(tracker)
    }
     */
}
