import Foundation

final class StatisticsViewModel: NSObject {
    // MARK: - Properties:
    var onChange: (()-> Void)?
    
    private (set) var records: [TrackerRecord] = [] {
        didSet {
            onChange?()
        }
    }
    // MARK: - Private Properties:
    private let recordStore = TrackerRecordStore.shared
    
    // MARK: - Methods:
    override init() {
        super.init()
        
    }
}
