import Foundation

final class CategoryViewModel: NSObject {
    // MARK: - Properties:
    var onChange: (() -> Void)?
    
    // MARK: - Private Properties:
    private let categoryStore = TrackerCategoryStore.shared
    private let trackersStore = TrackerStore.shared
    private(set) var categories = [TrackerCategory]() {
        didSet {
            onChange?()
        }
    }
    
    // MARK: - Methods:
    override init() {
        super.init()
        categoryStore.delegate = self
        categories = categoryStore.categories
    }
    
    func deleteCategory(_ title: String) {
        let trackers = categories.first { $0.name == title }?.includedTrackers
        trackers?.forEach({ trackersStore.deleteTracker($0) })
        if let categoryToDelete = try? categoryStore.getCategoryWith(title: title) {
            categoryStore.deleteCategory(categoryToDelete)
            print("Successfully deleted category")
        } else {
            print("Нет категорий для удаления")
            return
        }
    }
}

// MARK: - TrackerCategoryDelegate
extension CategoryViewModel: TrackerCategoryDelegate {
    func updateCategories() {
        categories = categoryStore.categories
    }
    
    
}
