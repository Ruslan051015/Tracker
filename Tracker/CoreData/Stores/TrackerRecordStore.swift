import Foundation
import UIKit
import CoreData

protocol TrackerRecordDelegate: AnyObject {
    func dudUpdateRecord()
}

final class TrackerRecordStore: NSObject {
    // MARK: - Properties:
    static let shared = TrackerRecordStore()
    var records: [TrackerRecord]? {
        guard
            let objects = self.recordFRC.fetchedObjects,
            let fetchedRecords = try? objects.map({ try self.createTrackerRecord(from: $0) }) else { return []
        }
        return fetchedRecords
    }
    
    // MARK: - Private properties:
    private var context: NSManagedObjectContext
    private lazy var recordFRC: NSFetchedResultsController<TrackerRecordCoreData> = {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
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
    
    // MARK: - Methods:
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
    
    func createTrackerRecord(from recordCD: TrackerRecordCoreData) throws -> TrackerRecord {
        guard
            let recordID = recordCD.recordID,
            let date = recordCD.date else {
            throw CDErrors.recordCoreDataCreatingError
        }
        let trackerRecord = TrackerRecord(id: recordID, date: date)
        return trackerRecord
    }
    
    func addRecord(for tracker: Tracker) throws -> TrackerRecordCoreData {
        let newRecord = TrackerRecordCoreData(context: context)
        newRecord.recordID = tracker.id
        newRecord.date = Date()
        saveContext()
        return newRecord
    }
    
    func deleteRecord(_ record: TrackerRecord) {
        deleteRecordFromCD(with: record.id, and: record.date)
    }
    
    func checkIfTrackerCompleted(with trackerID: UUID, and date: Date) -> Bool {
        let request = TrackerRecordCoreData.fetchRequest()
        request.predicate = NSPredicate(
            format: "%K == %@ AND %K == %@",
            #keyPath(TrackerRecordCoreData.recordID),
            trackerID as CVarArg,
            #keyPath(TrackerRecordCoreData.date),
            date as CVarArg)
        
        guard let trackersRecord = try? context.fetch(request) else {
            print("Не удалось выполнить запрос списка трекеров")
            return false
        }
        return !trackersRecord.isEmpty
    }
    
    func getNumberOfCompletionsForTracker(with id: UUID) -> Int {
        guard let trackerRecords = records else {
            print("Записей нет")
            return 0
        }
        return trackerRecords.map { $0.id == id }.count
    }
    
    // MARK: - Private Methods:
    private func deleteRecordFromCD(with id: UUID, and date: Date) {
        let request = TrackerRecordCoreData.fetchRequest()
        request.predicate = NSPredicate(
            format: "%K == %@ AND %K == %@",
            #keyPath(TrackerRecordCoreData.recordID),
            id as CVarArg,
            #keyPath(TrackerRecordCoreData.date),
            date as CVarArg)
        
        guard let trackersRecords = try? context.fetch(request) else {
            print("Не удалось выполнить запрос")
            return
        }
        if let recordToDelete = trackersRecords.first {
            context.delete(recordToDelete)
            saveContext()
        }
    }
}


