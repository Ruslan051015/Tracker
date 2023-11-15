import UIKit
import Foundation
import CoreData

final class TrackerStore: NSObject {
    // MARK: - Properties:
    static let shared = TrackerStore()
    
    // MARK: - Private Properties:
    private lazy var appdelegate: AppDelegate = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let context = appdelegate.getContext()
        return context
    }()
    
    // MARK: - Methods:
    func addTracker(_ tracker: Tracker) {
        let newTracker = TrackerCoreData(context: managedObjectContext)
        newTracker.id = tracker.id
        newTracker.name = tracker.name
        newTracker.color = tracker.color
        newTracker.emoji = tracker.emoji
        newTracker.schedule = tracker.schedule
    }
}
