import Foundation
import CoreData

final class TrackerCategoryStore: NSObject {
    // MARK: - Properties:
    var context: NSManagedObjectContext
    
    // MARK: - Methods:
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    
    
    
    func addCategory(_ name: String) {
        let newCategory = TrackerCategoryCoreData(context: context)
        newCategory.name = name
    }
    
    func deleteCategory(_ model: NSManagedObject) {
        context.delete(model)
    }
    
    func createCategoryFromCoreData(object: TrackerCategoryCoreData) throws -> TrackerCategory {
        guard let name = object.name,
              let trackers = object.trackers as? [Tracker] else {
            print("Не удалось обработать имя и трекеры")
            throw CoreDataErrors.creatingCategoryFromObjectError
        }
        let category = TrackerCategory(name: name, includedTrackers: trackers)
        return category
    }
}
