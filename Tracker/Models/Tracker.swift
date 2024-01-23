import Foundation
import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let schedule: [Weekday]?
    let color: UIColor
    let emoji: String
    let isPinned: Bool
}



