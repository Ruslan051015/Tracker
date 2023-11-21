import Foundation
import UIKit
import CoreData

final class TrackerRecordStore: NSObject {
    // MARK: - Properties:
    static let shared = TrackerRecordStore()
    
    // MARK: - Private properties:
   private var context: NSManagedObjectContext
    
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
    
    // MARK: - Methods
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
    
    func addRecord(for tracker: Tracker) throws -> TrackerRecordCoreData {
        let newRecord = TrackerRecordCoreData(context: context)
        newRecord.id = tracker.id
        newRecord.date = Date()
        saveContext()
        return newRecord
    }
  
}

