import UIKit
import Foundation
import CoreData

final class TrackerStore: NSObject  {
    // MARK: - Properties:
    static let shared = TrackerStore()
    // MARK: - Private properties:
    var context: NSManagedObjectContext
    
    // MARK: - Initializers:
    convenience override init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Не удалось инициализировать AppDelegate")
        }
        let context = appDelegate.persistentContainer.viewContext
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    
    // MARK: - CoreData Methods:
    func createCoreDataTracker(from tracker: Tracker, with category: String) {
        let newTracker = TrackerCoreData(context: context)
        newTracker.id = tracker.id
        newTracker.name = tracker.name
        newTracker.color = tracker.color
        newTracker.emoji = tracker.emoji
        newTracker.setValue(tracker.schedule, forKey: "schedule")
        newTracker.record = []
    }
    
    func createTrackerFromCoreData(_ model: TrackerCoreData) throws -> Tracker {
        guard
            let id = model.id,
            let name = model.name,
            let color = model.value(forKey: "color") as? UIColor,
            let emoji = model.emoji,
            let schedule = model.schedule as? [Weekday] else {
            print("Не удалось получить данные из БД")
            throw CDErrors.creatingTrackerFromModelError
        }
        return Tracker(
            id: id,
            name: name,
            schedule: schedule,
            color: color,
            emoji: emoji)
    }
    
    /* MARK: - TODO: In next sprints
    func deleteTracker(_ tracker: TrackerCoreData) {
        context.delete(tracker)
    }
     */
}
