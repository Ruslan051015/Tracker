import UIKit
import Foundation
import CoreData

protocol TrackerStoreDelegate: AnyObject {
    func dudUpdateTrackers()
}

final class TrackerStore: NSObject  {
    // MARK: - Properties:
    weak var delegate: TrackerStoreDelegate?
    static let shared = TrackerStore()
    var trackers: [Tracker] {
        guard
            let objects = self.trackersFRC.fetchedObjects,
            let trackers = try? objects.map({ try createTrackerFromCoreData($0) }) else {
            return []
        }
        return trackers
    }
    // MARK: - Private properties:
    private var context: NSManagedObjectContext
    private let recordStore = TrackerRecordStore.shared
    private lazy var trackersFRC: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        return controller
    }()
    
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
    
    func updateTrackerRecord(for record: TrackerRecord) throws {
        let request = TrackerCoreData.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCoreData.trackerID), record.id.uuidString)
        
        guard let trackers = try? context.fetch(request) else {
            print("Hе удалось выполнить запрос")
            return
        }
        if let trackerCD = trackers.first {
            let trackerRecord = TrackerRecordCoreData(context: context)
            trackerRecord.recordID = record.id
            trackerRecord.date = record.date
            trackerCD.addToRecord(trackerRecord)
            saveContext()
        }
    }
    
    func createCoreDataTracker(from tracker: Tracker, with category: TrackerCategoryCoreData) throws {
        let newTracker = TrackerCoreData(context: context)
        newTracker.trackerID = tracker.id
        newTracker.name = tracker.name
        newTracker.color = tracker.color
        newTracker.emoji = tracker.emoji
        newTracker.schedule = tracker.schedule as? NSObject
        newTracker.category = category
        newTracker.record = []
        saveContext()
    }
    
    func createTrackerFromCoreData(_ model: TrackerCoreData) throws -> Tracker {
        guard
            let id = model.trackerID,
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
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dudUpdateTrackers()
    }
}
