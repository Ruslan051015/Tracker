import Foundation
import UIKit
import CoreData

protocol CategoryCoreDataProtocol {
    var numberOfSections: Int { get }
}

protocol CategoryStoreDelegate: AnyObject {
    func didUpdate(indexes: updateIndexes, from: TrackerCategoryStore)
}

struct updateIndexes {
    struct Move: Hashable {
        let oldIndex: Int
        let newIndex: Int
    }
    let insertedIndexes: IndexSet
    let deletedIndexes: IndexSet
    let updatedIndexes: IndexSet
    let movedIndexes: Set<Move>
}

final class TrackerCategoryStore: NSObject {
    // MARK: - Properties:
    static let shared = TrackerCategoryStore()
    var categories: [TrackerCategory] {
        guard
            let objects = self.categoryFRC.fetchedObjects,
            let categories = try? objects.map({ try self.createCategoryFromCoreData($0) }) else { return []
        }
        return categories
    }
    
    // MARK: - Private properties:
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    private var updatedIndexes: IndexSet?
    private var moveIndexes: updateIndexes.Move?
    
    private let context: NSManagedObjectContext
    private let trackerStore = TrackerStore.shared
    
    private lazy var categoryFRC: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
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
    
    func deleteCategory(_ model: TrackerCategoryCoreData) {
        guard let objectToDelete = categoryFRC.fetchedObjects?.first(where: { $0.name == model.name }) else {
            print("Не удалось найти категорию для удаления")
            return }
        categoryFRC.managedObjectContext.delete(objectToDelete)
        saveContext()
    }
    
    func createCoreDataCategory(with name: String) {
        let category = TrackerCategoryCoreData(context: context)
        category.name = name
        category.trackers = []
        saveContext()
    }
    
    func createCategoryFromCoreData(_ model: TrackerCategoryCoreData) throws -> TrackerCategory {
        guard let name = model.name else {
            throw CDErrors.categoryTitleError
        }
        guard let trackers = model.trackers else {
            throw CDErrors.categoryTrackersError
        }
        
        let category = TrackerCategory(
            name: name,
            includedTrackers: trackers.compactMap { coreDataTracker -> Tracker? in
                if let coreDataTracker = coreDataTracker as? TrackerCoreData {
                    return try? trackerStore.createTrackerFromCoreData(coreDataTracker)
                } else {
                    return nil
                }
            })
        
        return category
    }
    
    func getCategoriesList() -> [String] {
        let request = TrackerCategoryCoreData.fetchRequest()
        request.returnsObjectsAsFaults = false
        var stringArray: [String] = []
        do {
            let objects = try context.fetch(request)
            stringArray = objects.compactMap { try? createCategoryFromCoreData(_:$0)}.map { $0.name }
        } catch {
            print("Не удалось получить категории")
        }
        return stringArray
    }
    
    func getCategoryWith(title: String) throws -> TrackerCategoryCoreData? {
        let request = categoryFRC.fetchRequest
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCategoryCoreData.name), title)
        do {
            let category = try context.fetch(request)
            return category.first
        } catch {
            throw CDErrors.getCoreDataCategoryError
        }
    }
}

// MARK: - CategoryCoreDataProtocol
extension TrackerCategoryStore: CategoryCoreDataProtocol {
    var numberOfSections: Int {
        categories.count
    }
}

// MARK: - CategoryCoreDataProtocol
extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    
}
