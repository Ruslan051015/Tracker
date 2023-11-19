import Foundation
import CoreData

final class TrackerRecordStore: NSObject {
    // MARK: - Properties:
    var context: NSManagedObjectContext
    
    // MARK: - Methods:
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    
    func addRecord(for tracker: Tracker) {
        let newRecord = TrackerRecordCoreData(context: context)
        newRecord.id = tracker.id
        newRecord.date = Date()
    }
  
}

