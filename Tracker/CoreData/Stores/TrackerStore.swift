import UIKit
import Foundation
import CoreData

protocol TrackerDelegate: AnyObject {
    func didUpdateTrackers()
}

final class TrackerStore: NSObject  {
    // MARK: - Properties:
    weak var delegate: TrackerDelegate?
    static let shared = TrackerStore()
    var trackers: [Tracker] {
        guard
            let fetchedResultsController = self.trackersFetchedResultsController,
            let objects = fetchedResultsController.fetchedObjects,
            let trackers = try? objects.map({ try createTrackerFromCoreData($0) }) else {
            return []
        }
        return trackers
    }
    // MARK: - Private properties:
    private var context: NSManagedObjectContext
    private let recordStore = TrackerRecordStore.shared
    private var trackersFetchedResultsController: NSFetchedResultsController<TrackerCoreData>?
    
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
        
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        self.trackersFetchedResultsController = controller
        try? controller.performFetch()
    }
    
    // MARK: - CoreData Methods:
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func pinTrackerCoreData(_ tracker: Tracker) {
        let request = TrackerCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCoreData.trackerID), tracker.id as CVarArg)
        
        guard let trackerCD = try? context.fetch(request) else {
            return
        }
        if let trackerToPin = trackerCD.first {
            if trackerToPin.pin == false {
                trackerToPin.pin = true
            } else if trackerToPin.pin == true {
                trackerToPin.pin = false
            }
            saveContext()
        }
    }
    
    func updateTrackerRecord(with record: TrackerRecord) throws {
        let newRecord = recordStore.createCDTrackerRecord(from: record)
        let request = TrackerCoreData.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCoreData.trackerID), record.id as CVarArg)
        
        guard let trackers = try? context.fetch(request) else {
            return
        }
        if let trackerCD = trackers.first {
            trackerCD.addToRecord(newRecord)
            saveContext()
        }
    }
    
    func createCoreDataTracker(
        from tracker: Tracker,
        with category: TrackerCategoryCoreData) throws {
            let newTracker = TrackerCoreData(context: context)
            newTracker.trackerID = tracker.id
            newTracker.name = tracker.name
            newTracker.color = tracker.color
            newTracker.emoji = tracker.emoji
            newTracker.schedule = tracker.schedule as? NSObject
            newTracker.category = category
            newTracker.record = []
            newTracker.pin = tracker.isPinned
            saveContext()
        }
    
    func createTrackerFromCoreData(_ model: TrackerCoreData) throws -> Tracker {
        guard
            let id = model.trackerID,
            let name = model.name,
            let color = model.value(forKey: "color") as? UIColor,
            let emoji = model.emoji,
            let schedule = model.schedule as? [Weekday] else {
            throw CDErrors.creatingTrackerFromModelError
        }
        let isPinned = model.pin
        return Tracker(
            id: id,
            name: name,
            schedule: schedule,
            color: color,
            emoji: emoji,
            isPinned: isPinned)
    }
    
    func deleteTracker(_ model: Tracker) {
        let id = model.id
        let request = TrackerCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCoreData.trackerID), id as CVarArg)
        
        guard let trackers = try? context.fetch(request) else {
            return
        }
        if let tracker = trackers.first {
            context.delete(tracker)
            saveContext()
        }
    }
    
    func updateTracker(_ updatedTracker: Tracker, with category: TrackerCategoryCoreData) {
        guard let trackerToUpdate = trackersFetchedResultsController?.fetchedObjects?.first(where: { $0.trackerID == updatedTracker.id
        }) else {
            return
        }
        trackerToUpdate.name = updatedTracker.name
        trackerToUpdate.category = category
        trackerToUpdate.schedule = updatedTracker.schedule as? NSObject
        trackerToUpdate.emoji = updatedTracker.emoji
        trackerToUpdate.color = updatedTracker.color
        
        saveContext()
    }
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdateTrackers()
    }
}

