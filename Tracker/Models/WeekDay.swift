import Foundation

enum Weekday: CaseIterable, Codable {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    var calendarNumber: Int {
        switch self {
        case .Monday:
            return 2
        case .Tuesday:
            return 3
        case .Wednesday:
            return 4
        case .Thursday:
            return 5
        case . Friday:
            return 6
        case .Saturday:
            return 7
        case .Sunday:
            return 1
        }
    }
    
    var dayNumber: Int {
        switch self {
        case .Monday:
            return 1
        case .Tuesday:
            return 2
        case .Wednesday:
            return 3
        case .Thursday:
            return 4
        case . Friday:
            return 5
        case .Saturday:
            return 6
        case .Sunday:
            return 7
        }
    }
    
    var localizedName: String {
        switch self {
        case .Monday:
            return L10n.Day.monday
        case .Tuesday:
            return L10n.Day.tuesday
        case .Wednesday:
            return L10n.Day.wednesday
        case .Thursday:
            return L10n.Day.thursday
        case .Friday:
            return L10n.Day.friday
        case .Saturday:
            return L10n.Day.saturday
        case .Sunday:
            return L10n.Day.sunday
        }
    }
    var shortName: String {
        switch self {
        case .Monday:
            return L10n.Day.Short.monday
        case .Tuesday:
            return L10n.Day.Short.tuesday
        case .Wednesday:
            return L10n.Day.Short.wednesday
        case .Thursday:
            return L10n.Day.Short.thursday
        case . Friday:
            return L10n.Day.Short.friday
        case .Saturday:
            return L10n.Day.Short.saturday
        case .Sunday:
            return L10n.Day.Short.sunday
        }
    }
}
