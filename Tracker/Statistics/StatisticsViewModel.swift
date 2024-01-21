import Foundation

final class StatisticsViewModel: NSObject {
    var onChange: (()-> Void)?
    
    private (set) var records: [TrackerRecord] = [] {
        didSet {
            onChange?()
        }
    }
}
