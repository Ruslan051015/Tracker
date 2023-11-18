import Foundation
import CoreData

protocol CategoryStoreProtocol {
    var context: NSManagedObjectContext { get }
    func addCategory()
//    func deleteCatefory()
}

final class TrackerCategoryStore: NSObject {
    // MARK: - Properties:
    var context: NSManagedObjectContext
    
    // MARK: - Methods:
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    func addCategory(_ name: String, with) {
        let newCategory = TrackerCategoryCoreData(context: context)
        newCategory.name = name
        newCategory.trackers =
    }
}
