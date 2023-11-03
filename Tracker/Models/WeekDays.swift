import Foundation

enum Weekdays: String, CaseIterable {
    case Monday = "Понедельник"
    case Tuesday = "Вторник"
    case Wednesday = "Среда"
    case Thursday = "Четверг"
    case Friday = "Пятница"
    case Saturday = "Суббота"
    case Sunday = "Воскресенье"
    
    var dayNumber: Int {
        switch self {
        case .Monday:
            return 0
        case .Tuesday:
            return 1
        case .Wednesday:
            return 2
        case .Thursday:
            return 3
        case . Friday:
            return 4
        case .Saturday:
            return 5
        case .Sunday:
            return 6
        }
    }
    
    var shortName: String {
        switch self {
        case .Monday:
            return "Пн"
        case .Tuesday:
            return "Вт"
        case .Wednesday:
            return "Ср"
        case .Thursday:
            return "Чт"
        case . Friday:
            return "Пт"
        case .Saturday:
            return "Сб"
        case .Sunday:
            return "Вс"
        }
    }
}
