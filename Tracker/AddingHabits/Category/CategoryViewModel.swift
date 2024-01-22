import Foundation

final class CategoryViewModel: NSObject {
    // MARK: - Properties:
    var onChange: (() -> Void)?
    
    // MARK: - Private Properties:
    private let categoryStore = TrackerCategoryStore.shared
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
}

// MARK: - TrackerCategoryDelegate
extension CategoryViewModel: TrackerCategoryDelegate {
    func updateCategories() {
        categories = categoryStore.categories
    }
    
    
}
