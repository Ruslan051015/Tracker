import Foundation

final class Mocks {
    static var trackers: [TrackerCategory] = [
        TrackerCategory(
            name: "Study",
            includedTrackers: [
                Tracker(
                    id: UUID(),
                    name: "Swift",
                    schedule: [.Monday, .Thursday, .Wednesday, .Friday, .Saturday, .Sunday]),
                Tracker(
                    id: UUID(),
                    name: "SwiftBook",
                    schedule: [.Monday, .Wednesday, .Saturday, .Sunday]),
                Tracker(
                    id: UUID(),
                    name: "Сomputer Science",
                    schedule: [.Monday, .Wednesday, .Saturday, .Sunday])
            ]),
        
        TrackerCategory(
            name: "Sport",
            includedTrackers: [
                Tracker(
                    id: UUID(),
                    name: "Gym",
                    schedule: [.Monday, .Wednesday, .Friday, .Sunday,]),
                Tracker(
                    id: UUID(),
                    name: "Football",
                    schedule: [.Wednesday])
            ])
    ]
}
