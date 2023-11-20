import UIKit
import CoreData

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

protocol CoreDataFacadeDelegate: AnyObject {
    func didUpdate(_ update: updateIndexes, from: CoreDataFacade)
}

protocol CoreDataFacadeProtocol {
    var numberOfSections: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func getTrackerFromCoreData(at: IndexPath) -> Tracker?
    func addTrackerToCoreData(_ tracker: Tracker) throws
    func deleteTrackerFromCoreData(at indexPath: IndexPath) throws
    func getCategoryFromCoreData(at: IndexPath) -> TrackerCategory?
    func addCategoryToCoreData(_ name: String) throws
    func deleteCategoryFromCoreData(_ name: IndexPath) throws
    func getRecordFromCoreData(at: IndexPath) -> TrackerRecord?
    func addRecordToCoreData(_ tracker: Tracker) throws
    func deleteRecordFromCoreData(_ tracker: Tracker) throws
}

enum CoreDataErrors: Error {
    case creatingTrackerFromObjectError
    case creatingCategoryFromObjectError
}

class CoreDataFacade: NSObject {
    // MARK: - Properties:
    
    
    // MARK: - Private Properties:
    private lazy var context: NSManagedObjectContext = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Не удалось получить AppDelegate")
        }
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    private lazy var trackersStore: TrackerStore = {
        let store = TrackerStore(context: context)
        
        return store
    }()
    
    private lazy var categoryStore: TrackerCategoryStore = {
        let store = TrackerCategoryStore(context: context)
        
        return store
    }()
    private lazy var recordStore: TrackerRecordStore = {
        let store = TrackerRecordStore(context: context)
        
        return store
    }()
    
    private lazy var categoryFRC: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        controller.delegate = self
        try? controller.performFetch()
        
        return controller
    }()
    
    private lazy var trackersFRC: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        controller.delegate = self
        try? controller.performFetch()
        
        return controller
    }()
    
    private lazy var recordFRC: NSFetchedResultsController<TrackerRecordCoreData> = {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        controller.delegate = self
        try? controller.performFetch()
        
        return controller
    }()
    
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    private var updatedIndexes: IndexSet?
    private var movedIndexes: Set<updateIndexes.Move>?
    weak var delegate: CoreDataFacadeDelegate?
    
    // MARK: - Methods
    init(delegate: CoreDataFacadeDelegate?) {
        self.delegate = delegate
    }
    
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
    
    func fetchCategories() {
        let request = TrackerCategoryCoreData.fetchRequest()
        request.returnsObjectsAsFaults = false
        let categories = try? context.fetch(request)
        print(categories)
    }
    
    
    
    
    // MARK: - Private Methods:
    
}


// MARK: - NSFetchedResultsControllerDelegate:
extension CoreDataFacade: NSFetchedResultsControllerDelegate {
    //    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    //
    //    }
    //
    //    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    ////        switch type {
    ////        case .insert:
    ////
    ////        case .delete:
    ////
    ////        case .update:
    ////
    ////        case .move:
    ////
    ////        @unknown default:
    ////            fatalError()
    ////        }
    //    }
    //
    //    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    //
    //    }
}
//
// MARK: - CoreDataFacadeProtocol:
extension CoreDataFacade: CoreDataFacadeProtocol {
    var numberOfSections: Int {
        guard let numberFfSections = categoryFRC.fetchedObjects?.count else {
            return 0
        }
        return numberFfSections
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        0
    }
    
    func getTrackerFromCoreData(at: IndexPath) -> Tracker? {
        nil
    }
    
    func addTrackerToCoreData(_ tracker: Tracker) throws {
        
    }
    
    func deleteTrackerFromCoreData(at indexPath: IndexPath) throws {
        
    }
    
    func getCategoryFromCoreData(at: IndexPath) -> TrackerCategory? {
        nil
    }
    
    func addCategoryToCoreData(_ name: String) throws {
        categoryStore.addCategory(name)
        saveContext()
    }
    
    func deleteCategoryFromCoreData(_ name: IndexPath) throws {
        
    }
    
    func getRecordFromCoreData(at: IndexPath) -> TrackerRecord? {
        nil
    }
    
    func addRecordToCoreData(_ tracker: Tracker) throws {
        
    }
    
    func deleteRecordFromCoreData(_ tracker: Tracker) throws {
        
    }
    
    
}

