import UIKit
import CoreData



protocol CoreDataFacadeDelegate: AnyObject {
    func didUpdate(_ update: updateIndexes, from: CoreDataFacade)
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


