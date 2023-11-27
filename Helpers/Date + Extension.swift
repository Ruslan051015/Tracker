import Foundation

extension Date {
        var onlyDate: DateComponents {
            Calendar.current.dateComponents([.year, .month, .day], from: self)
        }
    
    func returnOnlyDate() -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components)
    }
}
